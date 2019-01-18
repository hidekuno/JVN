#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# JVN Vulnerability Infomation Managed System
#
# hidekuno@gmail.com
#
from wsgi_handler import JvnApplication
from wsgi_handler import get_session_key
################################################################################
# DAO(データアクセスオブジェクト)
################################################################################
class JvnDAO(object):

    def __init__(self, app):
        self.app = app

    def get_records(self):
        sqlfmt = """select m.vname as vname, count(vd.cpe) as cnt
                    from jvn_vendor m, jvn_product p, jvn_vulnerability_detail vd
                    where m.vid= p.vid and vd.cpe = p.cpe
                    group by m.vname
                    having count(vd.cpe) >= 100
                    order by cnt desc"""

        self.app.cursor.execute(sqlfmt)
        rows = self.app.cursor.fetchall()
        return rows

################################################################################
# セッションデータ
################################################################################
class JvnState(object):
    def __init__(self):
        pass

################################################################################
# 初期表示処理
################################################################################
class Index(JvnApplication):
    def is_token_valid(self, req, session):
        return True

    def do_logic(self, req, res, session):
        self.title_name = 'JVN ベンダー別脆弱性件数'
        self.ui = session[get_session_key(req)] = JvnState()
        self.jinja_html_file = 'jvn_summary.html'
        dao = JvnDAO(self)
        self.result = dao.get_records()
