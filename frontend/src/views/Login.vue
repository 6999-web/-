<template>
  <div class="login-container">
    <div class="login-content">
      <!-- 顶部Logo和标题 -->
      <div class="header">
        <div class="logo-wrapper">
          <img src="/school-l.jpg" alt="校徽" class="logo" />
        </div>
        <h1 class="title">教研室数据管理平台</h1>
        <p class="subtitle">Teaching Office Data Management Platform</p>
      </div>

      <!-- 入口选择卡片 -->
      <div class="portal-cards">
        <!-- 教研室端 -->
        <div class="portal-card" @click="selectPortal('teaching-office')">
          <div class="card-icon teaching-office">
            <el-icon><Edit /></el-icon>
          </div>
          <h3 class="card-title">教研室端</h3>
          <p class="card-desc">教研室</p>
          <div class="card-features">
            <span class="feature-tag">自评分报</span>
            <span class="feature-tag">材料提交</span>
            <span class="feature-tag">改进措施</span>
          </div>
          <div class="card-arrow">
            <el-icon><ArrowRight /></el-icon>
          </div>
        </div>

        <!-- 管理端 -->
        <div class="portal-card" @click="selectPortal('management')">
          <div class="card-icon management">
            <el-icon><Setting /></el-icon>
          </div>
          <h3 class="card-title">管理端</h3>
          <p class="card-desc">评教小组、评教小组办公室、校长办公会</p>
          <div class="card-features">
            <span class="feature-tag">评分管理</span>
            <span class="feature-tag">数据审核</span>
            <span class="feature-tag">系统配置</span>
          </div>
        </div>

        <!-- 数据大屏 -->
        <div class="portal-card" @click="goToDashboard">
          <div class="card-icon dashboard">
            <el-icon><Monitor /></el-icon>
          </div>
          <h3 class="card-title">数据大屏</h3>
          <p class="card-desc">公开展示，无需登录</p>
          <div class="card-features">
            <span class="feature-tag">实时数据</span>
            <span class="feature-tag">可视化</span>
            <span class="feature-tag">排名对比</span>
          </div>
        </div>
      </div>

      <!-- 页脚 -->
      <div class="footer">
        <p>© 2024 教研室数据管理平台 | 版本 2.0.0</p>
      </div>
    </div>

    <!-- 登录对话框 -->
    <el-dialog
      v-model="showLoginDialog"
      :title="loginDialogTitle"
      width="400px"
      :close-on-click-modal="false"
      class="custom-dialog"
    >
      <el-form :model="loginForm" :rules="loginRules" ref="loginFormRef" label-width="80px">
        <el-form-item label="用户名" prop="username">
          <el-input
            v-model="loginForm.username"
            placeholder="请输入用户名"
            prefix-icon="User"
            @keyup.enter="handleLogin"
          />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input
            v-model="loginForm.password"
            type="password"
            placeholder="请输入密码"
            prefix-icon="Lock"
            show-password
            @keyup.enter="handleLogin"
          />
        </el-form-item>

        <el-form-item v-if="selectedPortal === 'management'" label="角色" prop="role">
          <el-select v-model="loginForm.role" placeholder="请选择角色" style="width: 100%">
            <el-option label="评教小组" value="evaluation_team" />
            <el-option label="评教小组办公室" value="evaluation_office" />
            <el-option label="校长办公会" value="president_office" />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="showLoginDialog = false">取消</el-button>
          <el-button type="primary" @click="handleLogin" :loading="loginLoading">
            登录
          </el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Edit, Setting, Monitor, ArrowRight, User, Lock, Loading } from '@element-plus/icons-vue'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const authStore = useAuthStore()

const showLoginDialog = ref(false)
const selectedPortal = ref<'teaching-office' | 'management' | ''>('')
const loginLoading = ref(false)
const loginFormRef = ref()

const loginForm = ref({
  username: '',
  password: '',
  role: ''
})

const loginRules = computed(() => {
  const rules: any = {
    username: [
      { required: true, message: '请输入用户名', trigger: 'blur' }
    ],
    password: [
      { required: true, message: '请输入密码', trigger: 'blur' },
      { min: 6, message: '密码长度不能少于6位', trigger: 'blur' }
    ]
  }
  
  if (selectedPortal.value === 'management') {
    rules.role = [
      { required: true, message: '请选择角色', trigger: 'change' }
    ]
  }
  
  return rules
})

const loginDialogTitle = computed(() => {
  if (selectedPortal.value === 'teaching-office') {
    return '教研室端登录'
  } else if (selectedPortal.value === 'management') {
    return '管理端登录'
  }
  return '登录'
})

const selectPortal = (portal: 'teaching-office' | 'management') => {
  selectedPortal.value = portal
  loginForm.value = {
    username: '',
    password: '',
    role: ''
  }
  showLoginDialog.value = true
}

const goToDashboard = () => {
  router.push('/data-dashboard')
}

const handleLogin = async () => {
  if (!loginFormRef.value) return
  
  await loginFormRef.value.validate(async (valid: boolean) => {
    if (valid) {
      loginLoading.value = true
      
      try {
        const response = await fetch('/api/auth/login', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            username: loginForm.value.username,
            password: loginForm.value.password,
            role: selectedPortal.value === 'teaching-office' ? 'teaching_office' : loginForm.value.role
          })
        })
        
        if (!response.ok) {
          const errorData = await response.json().catch(() => ({}))
          throw new Error(errorData.detail || '登录失败')
        }
        
        const data = await response.json()
        
        const user = {
          id: data.userId,
          name: loginForm.value.username,
          role: data.role,
          teaching_office_id: data.teachingOfficeId || ''
        }
        
        authStore.setAuth({
          token: data.token,
          user: user
        })
        
        ElMessage.success('登录成功！')
        showLoginDialog.value = false
        
        if (selectedPortal.value === 'teaching-office') {
          router.push('/teaching-office-home')
        } else if (selectedPortal.value === 'management') {
          router.push('/management-home')
        }
      } catch (error: any) {
        ElMessage.error(error.message || '登录失败，请检查用户名和密码')
      } finally {
        loginLoading.value = false
      }
    }
  })
}
</script>

<style scoped>
.login-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #1e3a5f; /* 纯蓝色背景 */
  position: relative;
  overflow: hidden;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
}

.login-content {
  position: relative;
  z-index: 1;
  width: 100%;
  max-width: 1200px;
  padding: 2rem;
}

/* 头部 */
.header {
  text-align: center;
  margin-bottom: 4rem;
}

.logo-wrapper {
  background: white;
  width: 110px;
  height: 110px;
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 1.5rem;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
  padding: 8px;
}

.logo {
  width: 90px;
  height: 90px;
  object-fit: contain;
}

.title {
  font-size: 2.8rem;
  font-weight: 700;
  color: white;
  margin-bottom: 0.8rem;
  letter-spacing: 2px;
}

.subtitle {
  font-size: 1.1rem;
  color: rgba(255, 255, 255, 0.8);
  letter-spacing: 1.5px;
}

/* 入口卡片 */
.portal-cards {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 2.5rem;
  margin-bottom: 4rem;
}

.portal-card {
  background: white;
  border-radius: 32px;
  padding: 2.5rem 2rem;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  display: flex;
  flex-direction: column;
  min-height: 280px;
}

.portal-card:hover {
  transform: translateY(-12px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
}

.card-icon {
  width: 70px;
  height: 70px;
  border-radius: 18px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 2rem;
  color: white;
  margin-bottom: 1.5rem;
}

.card-icon.teaching-office {
  background: #1e2a4a;
}

.card-icon.management {
  background: #1a233d;
}

.card-icon.dashboard {
  background: #151e33;
}

.card-title {
  font-size: 1.7rem;
  font-weight: 700;
  color: #1a1a1a;
  margin-bottom: 0.6rem;
}

.card-desc {
  font-size: 1rem;
  color: #666;
  margin-bottom: 1.5rem;
  line-height: 1.4;
}

.card-features {
  display: flex;
  flex-wrap: wrap;
  gap: 0.6rem;
  margin-top: auto;
}

.feature-tag {
  padding: 0.4rem 1rem;
  background: #eef2f7;
  border-radius: 20px;
  font-size: 0.9rem;
  color: #5c6b8a;
  font-weight: 500;
}

.card-arrow {
  position: absolute;
  bottom: 2rem;
  right: 2rem;
  font-size: 1.8rem;
  color: #8c98ac;
}

/* 页脚 */
.footer {
  text-align: center;
  color: rgba(255, 255, 255, 0.6);
  font-size: 0.95rem;
}

/* 响应式 */
@media (max-width: 1024px) {
  .portal-cards {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
}

/* 对话框定制 */
:deep(.el-dialog) {
  border-radius: 24px;
  overflow: hidden;
}

:deep(.el-dialog__header) {
  background: #1e3a5f;
  margin-right: 0;
  padding: 20px 24px;
}

:deep(.el-dialog__title) {
  color: white;
  font-size: 1.25rem;
}

:deep(.el-dialog__headerbtn .el-dialog__close) {
  color: white;
}
</style>
