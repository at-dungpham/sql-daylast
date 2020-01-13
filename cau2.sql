
-- cau 2: Thêm 1 dòng dữ liệu trong bất kỳ table nào
select * from news;
insert into news(id,category_id,title,view,is_active,content,created_at,updated_at)
values ('41','3','baitap 2','31','1','bai tap2','2020-01-06 15:30:30'
,'2020-01-05 14:20:20');

-- cau 3: Xoá và sửa 1 dòng dữ liệu trong bất kỳ table nào
delete from news where id="37";
update news set title="update title",content="update content" where id="41";

-- cau 4: Select 10 blog mới nhất đã active
select * from blog having is_active>0 order by id desc limit 10;

-- cau 5: Lấy 5 blog từ blog thứ 10
select * from blog where id between 10 and 15;

-- cau 6: Set is_active = 0 của user có id = 3 trong bảng user
update user set is_active=0 where id=3;

-- cau 7: Xoá tất cả comment của user = 2 trong blog = 5
delete from comment 
where target_table='blog' and target_id=5 and user_id =2;

-- cau 8: Lấy 3 blog bất kỳ (random)
select * 
from blog
order by rand()
limit 3;

-- cau 9:Lấy số lượng comment của các blog
select count(comment) as "luot comment"
from comment
where target_table='blog';

-- cau 10: Lấy Category có tồn tại blog hoặc news đã active (không được lặp lại category)

select distinct blog.category_id as category_blog,news.category_id as category_news
from blog
inner join news
on blog.category_id = news.category_id
where blog.is_active>0 and news.is_active>0;

-- cau 11: Lấy tổng lượt view của từng category thông qua blog và news
select sum(blog.view), sum(news.view)
from blog
inner join news
on blog.category_id = news.category_id;

-- cau 12: Lấy blog được tạo bởi user mà user này không có bất kỳ comment ở blog
SELECT distinct *
FROM blog 
where user_id 
not in (SELECT distinct user_id FROM comment where target_table="blog");

-- cau 13: Lấy 5 blog mới nhất và số lượng comment cho từng blog
select count(c.comment),c.target_id 
from (select * from blog order by id desc limit 5) as sub 
join comment as c on sub.id = c.target_id 
group by c.target_id;

-- cau 14: Lấy 3 User comment đầu tiên trong 5 blogs mới nhất
select c.user_id 
from (select * from blog order by id desc limit 5) as sub 
join comment as c on sub.id = c.target_id 
where c.target_table="blog" 
order by c.target_id 
asc limit 3;

-- cau 15: Update rank user = 2 khi tổng số lượng comment của user > 20
select user_id as id 
from (select count(comment) as rs ,user_id from comment group by user_id) as z
where rs >10;

-- cau 16: Xoá comment mà nội dung comment có từ "fuck" hoặc "phức"
delete 
from comment 
where comment 
like "%fuck%" and "%phức";