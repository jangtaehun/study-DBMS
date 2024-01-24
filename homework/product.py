from homework.connection_module import *
from homework.product_module import *

if __name__ == '__main__':
    # 상품 추가
    # insert_query = "insert into tbl_product(name, price, created_date) values(%s, %s, %s)"
    # insert_params = ['키보드', '100000', '2024-01-17T19:21:00']
    # save(insert_query, insert_params)

    # 전체 상품 조회
    # find_all_query = "select id, name, price, created_date from tbl_product"
    # products = find_all(find_all_query)
    # print(products)
    # for product in products:
    #     print(f'상품명: {product["name"]}, {product["price"]}')


    # 상품 정보 중 가격이 3000원 이상인 상품은 10% 할인해준다.
    # update_query = "update tbl_product set price = price - (price * 0.1) where price >= %s"
    # update_params = [3000]
    # update(update_query, update_params)


    # 평균 가격보다 높은 상품은 모두 삭제한다.
    # find_all_query = "select avg(price) as avg from tbl_product"
    # products_avg = find_all(find_all_query)
    # avg = products_avg[0]['avg']
    # delete_params = [avg]
    # delete_query = "delete from tbl_product where price > %s"
    # delete(delete_query, delete_params)

    #id 검색
    find_by_id_query = "select name from tbl_product where name = %s"
    params = ['마우스']
    member = find_by_id(find_by_id_query, params)
    print(member)


    # for product in products:
    #     print(f'상품명: {product["name"]}, {product["price"]}')