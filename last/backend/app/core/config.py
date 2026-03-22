from typing import List
from pydantic_settings import BaseSettings
from urllib.parse import quote_plus

class Settings(BaseSettings):
    PROJECT_NAME: str = "教研室工作考评系统"
    API_V1_STR: str = "/api"
    
    # MySQL 数据库配置
    MYSQL_SERVER: str = "localhost"
    MYSQL_USER: str = "jysuser"
    MYSQL_PASSWORD: str = "Jys@2026"
    MYSQL_DB: str = "jys_data"
    MYSQL_PORT: int = 3306
    
    # 数据库连接URL（自动生成）
    @property
    def DATABASE_URL(self) -> str:
        password = quote_plus(self.MYSQL_PASSWORD)
        return f"mysql+pymysql://{self.MYSQL_USER}:{password}@{self.MYSQL_SERVER}:{self.MYSQL_PORT}/{self.MYSQL_DB}?charset=utf8mb4"
    
    # MinIO
    MINIO_ENDPOINT: str = "localhost:9000"
    MINIO_ACCESS_KEY: str = "minioadmin"
    MINIO_SECRET_KEY: str = "minioadmin"
    MINIO_BUCKET: str = "teaching-office-attachments"
    MINIO_SECURE: bool = False
    
    # JWT
    SECRET_KEY: str = "your-secret-key-change-in-production"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 7  # 7 days
    
    # DeepSeek API
    DEEPSEEK_API_KEY: str = ""
    DEEPSEEK_API_URL: str = "https://api.deepseek.com/v1/chat/completions"
    
    # CORS - 允许的前端访问地址
    BACKEND_CORS_ORIGINS: List[str] = [
        "http://localhost:3000",
        "http://localhost:5173",
        "http://127.0.0.1:3000",
        "http://127.0.0.1:5173",
        "http://101.33.211.98",
        "http://101.33.211.98:80",
        "http://101.33.211.98:3000",
        "http://101.33.211.98:5173",
        "http://101.33.211.98:8000",
        "https://101.33.211.98",
        "https://101.33.211.98:443",
        "http://101.33.210.169:38888",
        "http://101.33.210.169"
    ]
    
    class Config:
        env_file = ".env"
        case_sensitive = True

settings = Settings()
