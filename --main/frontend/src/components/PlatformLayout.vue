<template>
  <div class="platform-layout">
    <!-- 移动端顶部通栏 -->
    <div class="mobile-top-bar">
      <el-button @click="isSidebarOpen = !isSidebarOpen" :icon="Menu" circle class="menu-btn" />
      <span class="mobile-title">教研室数据管理平台</span>
      <div class="mobile-spacer"></div>
    </div>

    <!-- 左侧导航栏 -->
    <div class="sidebar" :class="{ 'is-open': isSidebarOpen }">
      <div class="sidebar-header" @click="goToHome">
        <img src="/school-logo.jpg" alt="校徽" class="sidebar-logo" />
        <h2 class="sidebar-title">教研室数据管理平台</h2>
      </div>
      
      <div class="sidebar-menu">
        <div 
          v-for="(module, index) in modules" 
          :key="index"
          class="menu-item"
          :class="{ active: isModuleActive(module.path) }"
          @click="handleNavigate(module.path)"
        >
          <el-icon class="menu-icon">
            <component :is="module.icon" />
          </el-icon>
          <span class="menu-text">{{ module.name }}</span>
        </div>
      </div>
      
      <div class="sidebar-footer">
        <div class="user-info">
          <el-icon class="user-avatar"><User /></el-icon>
          <span class="user-name">admin</span>
        </div>
      </div>
    </div>

    <!-- 侧边栏遮罩层 -->
    <transition name="fade">
      <div v-if="isSidebarOpen" class="sidebar-overlay" @click="isSidebarOpen = false"></div>
    </transition>

    <!-- 右侧主内容区 -->
    <div class="main-content">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { User, Edit, Setting, Monitor, Menu } from '@element-plus/icons-vue'

const isSidebarOpen = ref(false)

const router = useRouter()
const route = useRoute()

const modules = [
  { name: '教研室端', icon: Edit, path: '/' },
  { name: '管理端', icon: Setting, path: '/' },
  { name: '校长办公会端', icon: Monitor, path: '/' }
]

const goToHome = () => {
  router.push('/')
}

const navigateTo = (path: string) => {
  router.push(path).catch(err => {
    console.error('导航失败:', err)
  })
}

const handleNavigate = (path: string) => {
  navigateTo(path)
  if (window.innerWidth <= 768) {
    isSidebarOpen.value = false
  }
}

const isModuleActive = (path: string) => {
  return route.path === path
}
</script>

<style scoped>
/* 平台布局 */
.platform-layout {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  background: #f5f7fa;
}

@media (min-width: 769px) {
  .platform-layout {
    flex-direction: row;
  }
}

.mobile-top-bar {
  display: none;
}

/* 左侧边栏 */
.sidebar {
  width: 200px;
  background: #1e3a5f;
  display: flex;
  flex-direction: column;
  position: fixed;
  left: 0;
  top: 0;
  bottom: 0;
  z-index: 1000;
}

.sidebar-header {
  padding: 1.5rem 1rem;
  text-align: center;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  cursor: pointer;
  transition: background 0.3s;
}

.sidebar-header:hover {
  background: rgba(255, 255, 255, 0.05);
}

.sidebar-logo {
  width: 60px;
  height: 60px;
  object-fit: contain;
  border-radius: 8px;
  margin-bottom: 0.5rem;
}

.sidebar-title {
  color: white;
  font-size: 1.1rem;
  font-weight: 600;
  margin: 0;
}

.sidebar-menu {
  flex: 1;
  padding: 1rem 0;
  overflow-y: auto;
}

.menu-item {
  display: flex;
  align-items: center;
  padding: 1rem 1.5rem;
  color: rgba(255, 255, 255, 0.7);
  cursor: pointer;
  transition: all 0.3s;
  border-left: 3px solid transparent;
}

.menu-item:hover {
  background: rgba(255, 255, 255, 0.05);
  color: white;
}

.menu-item.active {
  background: rgba(255, 255, 255, 0.1);
  color: white;
  border-left-color: #7cb342;
}

.menu-icon {
  font-size: 1.3rem;
  margin-right: 0.75rem;
}

.menu-text {
  font-size: 0.95rem;
  font-weight: 500;
}

.sidebar-footer {
  padding: 1rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.user-info {
  display: flex;
  align-items: center;
  padding: 0.75rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 8px;
  color: white;
}

.user-avatar {
  font-size: 1.5rem;
  margin-right: 0.5rem;
}

.user-name {
  font-size: 0.9rem;
}

/* 主内容区 */
.main-content {
  flex: 1;
  margin-left: 200px;
  min-height: 100vh;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .mobile-top-bar {
    display: flex;
    align-items: center;
    background: #1e3a5f;
    color: white;
    padding: 0.75rem 1rem;
    position: sticky;
    top: 0;
    z-index: 1001;
    box-shadow: 0 2px 10px rgba(0,0,0,0.2);
  }
  
  .menu-btn {
    background: transparent;
    border: none;
    color: white;
    font-size: 1.25rem;
  }
  
  .mobile-title {
    font-size: 1.1rem;
    font-weight: 600;
    margin-left: 1rem;
  }
  
  .mobile-spacer {
    flex: 1;
  }

  .sidebar {
    left: -200px;
    width: 200px;
    transition: transform 0.3s ease;
    box-shadow: 2px 0 15px rgba(0,0,0,0.2);
  }
  
  .sidebar.is-open {
    transform: translateX(200px);
  }
  
  .sidebar-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.5);
    z-index: 999;
  }

  .main-content {
    margin-left: 0;
  }
  
  .sidebar-title,
  .menu-text,
  .user-name {
    display: block; /* 在抽屉里要显示文字 */
  }
}

.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s;
}
.fade-enter-from, .fade-leave-to {
  opacity: 0;
}
</style>
