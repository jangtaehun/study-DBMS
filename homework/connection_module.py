import pymysql
from pymysql.cursors import Cursor


# 원하는 MySQL 서버와 연동하는 함수
def connect():
    conn = pymysql.connect(host='43.201.16.176', user='mysql', password='1234', db='test', charset='utf8', autocommit=False)
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    return conn, cursor


# crud: save, find_all, find_by_id, update, delete 중 한 가지가 들어온다.
def execute(crud):
    result = None

    def manage(*args):
        print(f'args: {args}')
        nonlocal result
        # 연결객체와 커서객체를 받아온다.
        conn, cursor = connect()
        try:
            # crud 함수 실행, cursor객체를 전달해줌으로써 해당 쿼리가 실행되도록 한다.
            result = crud(cursor, *args)
            conn.commit()
        except Exception as e:
            print(e.__str__())
            conn.rollback()

        finally:
            cursor.close()
            conn.close()

        return result

    return manage
















