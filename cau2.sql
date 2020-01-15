
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
select sum(blog.view), sum(news.view), blog.category_id
from blog
inner join news
on blog.category_id = news.category_id
group by blog.category_id;

-- cau 12: Lấy blog được tạo bởi user mà user này không có bất kỳ comment ở blog
SELECT distinct *
FROM blog 
where user_id 
not in (SELECT distinct user_id FROM comment where target_table="blog");

-- cau 13: Lấy 5 blog mới nhất và số lượng comment cho từng blog
select count(c.comment),c.target_id 
from (select * from blog order by id desc limit 5) as b 
join (select * from comment where target_table="blog") as c 
on b.id = c.target_id 
group by c.target_id;

-- cau 14: Lấy 3 User comment đầu tiên trong 5 blogs mới nhất
select c.user_id 
from (select * from blog order by id desc limit 5) as b 
join comment as c 
on b.id = c.target_id 
where c.target_table="blog" 
order by c.target_id asc 
limit 3;

-- cau 15: Update rank user = 2 khi tổng số lượng comment của user > 20
select user_id as id 
from (select count(comment) as rs ,user_id from comment group by user_id) as z
where rs >10;

-- cau 16: Xoá comment mà nội dung comment có từ "fuck" hoặc "phức" (chua dc)
delete 
from comment 
where comment 
like "%fuck%" or "%phức%";

-- cau 17: Select 10 blog mới nhất được tạo bởi các user active

-- cau 18: Lấy số lượng Blog active của user có id là 1,2,4
select count(is_active), user_id
from blog
where is_active>0 and user_id in (1,2,4)
group by user_id;

-- cau 19: Lấy 5 blog và 5 news của 1 category bất kỳ (chua dc)
select b.id as randblog, n.id as randnews, b.category_id
from blog as b
join news as n
on b.category_id = n.category_id
order by rand()
limit 5;

-- cau 20: Lấy blog và news có lượt view nhiều nhất
select max(b.view) as maxBlog, max(n.view) as maxNews
from blog as b
join news as n
on b.category_id = n.category_id;

-- cau 21: Lấy blog được tạo trong 3 ngày gần nhất

-- cau 22: Lấy danh sách user đã comment trong 2 blog mới nhất
select c.user_id
from comment as c
where target_table="blog"
order by c.user_id desc
limit 2;

-- cau 23: Lấy 2 blog, 2 news mà user có id = 1 đã comment
select b.id as 2blog, n.id as 2news
from blog as b
join news as n
on b.category_id = n.category_id
order by rand()
limit 2;

-- cau 24: Lấy 1 blog và 1 news có số lượng comment nhiều nhất
(select count(comment),target_id from comment where target_table = "blog" group by target_id order by count(comment) desc limit 1)
union
(select count(comment),target_id from comment where target_table = "news" group by target_id order by count(comment) desc limit 1);

-- cau 25: Lấy 5 blog và 5 news mới nhất đã active
(select id,content from blog where is_active > 0 order by id desc limit 5)
union
(select id,content from news where is_active > 0 order by id desc limit 5);

-- cau 26: Lấy nội dung comment trong blog và news của user id =1
select comment 
from comment 
where user_id = 1;

-- cau 27: Blog của user đang được user có id = 1 follow
select * 
from blog as b 
join (select to_user_id from follow where from_user_id = 1) as rs 
on b.user_id = rs.to_user_id;

-- cau 28: Lấy số lượng user đang follow user = 1
select count(from_user_id), to_user_id
from follow
where to_user_id="1";

-- cau 29: Lấy số lượng user 1 đang follow
select from_user_id, count(to_user_id)
from follow
where from_user_id="1"
group by from_user_id;

-- cau 30: Lấy 1 comment(id_comment, comment) mới nhất và thông tin user của user đang được follow bởi user 1 (chua dc)
(select c.id,c.comment from comment as c order by c.id desc limit 1)
union
(select * from follow where to_user_id ="1");

-- cau 31: Hiển thị một chuổi "PHP Team " + ngày giờ hiện tại (Ex: PHP Team 2017-06-21 13:06:37)
SELECT CONCAT("PHP Team ", NOW()) AS SEQUENCE;

-- cau 32: Tìm có tên(user.full_name) "Khiêu" và các thông tin trên blog của user này như: (blog.title, blog.view), title category(category) của blog này. Hiển thị theo output như bên dưới:
select u.full_name, b.title, b.view, b.category_id
from user u
join blog b
on u.id = b.user_id
join category ca
on b.category_id = ca.id
where u.full_name like "%khiêu%";

-- cau 33: Liệt kê email user các user có tên(user.full_name) có chứa ký tự "Khi" theo danh sách như output bên dưới.
select u.email, u.full_name
from user u
where u.full_name like "%khi%";

-- cau 34: Tính điểm cho user có email là minh82@example.com trong bảng comment. Cách tính điểm: Trong bảng comment với taget_table = "blog" tính 1 điểm, taget_table = "news" tính 2 điểm.
SELECT email,SUM(CASE taget_table WHEN “blog” THEN 1 ELSE 2 END) AS DIEM FROM user INNER JOIN comment ON user.id = comment.user_id WHERE email = “minh82@example.com”;
