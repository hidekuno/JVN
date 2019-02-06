#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# JVN Vulnerability Infomation Managed System
#
# hidekuno@gmail.com
#

from sqlalchemy import orm
from sqlalchemy import create_engine, Column, Integer, String,SmallInteger, DateTime
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
################################################################################
# アカウント情報(Model)
################################################################################
class Account(Base):
    __tablename__ = 'jvn_account'
 
    user_id    = Column(String, nullable=False, primary_key=True)
    passwd     = Column(String)
    user_name  = Column(String)
    email      = Column(String)
    department = Column(String)
    privs      = Column(String)
 
    def __init__(self,row, passwd):
        self.user_id     = row['user_id']
        self.passwd      = passwd
        self.user_name   = row['user_name']
        self.email       = row['email']
        self.department  = row['department']
        self.privs       = row['privs']
################################################################################
# 製品情報(Model)
################################################################################
class Product(Base):
    __tablename__ = 'jvn_product'

    pid       = Column(Integer, nullable=False)
    pname     = Column(String,  nullable=False)
    cpe       = Column(String,  nullable=False, primary_key=True)
    vid       = Column(Integer, nullable=False)
    fs_manage = Column(String,  nullable=False)
    edit      = Column(SmallInteger)

################################################################################
# 脆弱性情報(Model)
################################################################################
class Vulnerability(Base):
    __tablename__ = 'jvn_vulnerability'

    identifier           = Column(String,  nullable=False, primary_key=True)
    title                = Column(String,  nullable=False)
    link                 = Column(String,  nullable=False)
    description          = Column(String,  nullable=False)
    issued_date          = Column(String,  nullable=False)
    modified_date        = Column(DateTime,  nullable=False)
    ticket_modified_date = Column(DateTime)

################################################################################
# トランザクション処理
################################################################################
def do_transaction(func,app):
    ret = None
    engine = None

    try:
        dburl = 'postgres://%s:%s@%s:%s/%s' % (app.config.get('db','user')
                                               ,app.config.get('db','password')
                                               ,app.config.get('db','host')
                                               ,app.config.get('db','port')
                                               ,app.config.get('db','database'))
        engine = create_engine(dburl)
        Session = orm.scoped_session(orm.sessionmaker(bind=engine, expire_on_commit=False))
        db = Session()
        ret = func(db)
        db.commit()

    except Exception as e:
        db.rollback()
        raise e

    finally:
        if engine:
            engine.dispose()
    return ret
