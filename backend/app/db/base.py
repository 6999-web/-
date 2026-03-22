from sqlalchemy import create_engine, event
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy.pool import QueuePool
from app.core.config import settings
import logging

logger = logging.getLogger(__name__)

# 创建数据库引擎
# MySQL 配置（不使用连接池）
engine = create_engine(
    settings.DATABASE_URL,
    # 不使用连接池
    poolclass=None,
    # 连接超时：30秒
    connect_args={"connect_timeout": 30},
    # 启用SQL日志（开发环境）
    echo=False
)
logger.info("使用 MySQL 数据库")

# 监听连接事件，记录连接池状态
@event.listens_for(engine, "connect")
def receive_connect(dbapi_conn, connection_record):
    """连接建立时的回调"""
    logger.debug("数据库连接已建立")

@event.listens_for(engine, "checkout")
def receive_checkout(dbapi_conn, connection_record, connection_proxy):
    """从连接池获取连接时的回调"""
    logger.debug("从连接池获取连接")

@event.listens_for(engine, "checkin")
def receive_checkin(dbapi_conn, connection_record):
    """连接归还到连接池时的回调"""
    logger.debug("连接归还到连接池")

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

def get_db():
    """
    获取数据库会话
    
    使用依赖注入提供数据库会话，自动处理连接的获取和释放
    """
    db = SessionLocal()
    try:
        yield db
    except Exception as e:
        logger.error(f"数据库会话异常: {str(e)}")
        db.rollback()
        raise
    finally:
        db.close()
