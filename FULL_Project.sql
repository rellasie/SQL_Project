create database test
use test

create table users
(
  id int identity(1,1),
  Username char(20),
  passwords char (32),
  email char(100),
)

insert into users (Username, passwords, email)
values 
('S2jriStS7mKdRhjHJt0V','iYroVq3hGyZYXBeKf0mKQv','gS4VltlQIZPe9xgDmeHB@gmail.com'),
('JFEkVD2HG0XBeKf0mKQv','tqZXFmVuiroQKQYqK9g','9DsF26Up1E1D4V@sis.hust.edu.vn'),
('KQYqK9gSjpUhuEBBIlFg','G315g0BDKmvgonGBjFqrnks','Phbafx8FlNjNbk@yahoo.com'),
('UnonGBjFqrnks7EdpEDq','HONW9KFZ53VpRNwULKVh','eOAomn6w7pAJp8pax@gmail.com'),
('RNwULKVhTDaJ9xWeARtb','Kf6LFKymHK5DDDGEZWpZS','pSBPhDXI0xwE4CP@gmail.com'),
('YWDDGEZWpZSX0vpMugEh','ZKA1u0ZMrDF2A0WS4Vf7fL','ObjKNzJrglzSZ@gmail.com'),
('sEgkeA0WS4Vf7fLHMSGg','bNLK3YiKxQyyqzzqpadyay','HUL24UyYbCeNdiNz@yahoo.com'),
('YRRj5vQsAqzzqpadyayz','pq1fkj6UnTWcBGmaZZp','MaTJLO5xWFrVcK1b@gmail.com'),
('xtUKIZQ82wAsBGmaZZpY','mZC25fm3WzuwNZupdo1c','SgJ9IN8Xw5JGX6gW@gmail.com'),
('8YQHCe9ILrSlPC6aWj1E','tmcKRoTzydaAo1cHTFkY','QL3GkkmwRSCmSu67@yahoo.com'),
('1TSfNZupdo1cHTFkYYw8','J1PeA0lgYTs4mmWV5a9','oxs7iYyf3WCPgnr@gmail.com'),
('k33OVvZuNUmmWV5a9G76','muuBKf0KwrYJ4KtsvAG','gVoWNxJCTCcfDyO@yahoo.com'),
('BZL6CMSW6MZHA4KtsvAG','RuKNj3QVQ2wbQP3DUIz1','nZRNwyqQ9rh375Hkm@yahoo.com'),
('NN2qJEEutOQP3DUIz1KS','xKrwapugfAFNUBnLdUZmeo7a','nXEExC80qT6TXmYPCF@yahoo.com'),
('FwJlpufUBnLdUZmeo7a7','CyjzPwjgVLYFNN2qJEEutOQP3DUIz1KS','iiE5EMe2uu0SMGXsCWK@gmail.com'),
('gLwiqPd0Zzc7jQnNHbrM','jTCPnU6FqHsWfPPn3cf6T','BqyB6T5aroIaT@yahoo.com'),
('n9Jl7OofPPn3cf6TAym4','b4FvSWoYeyDmVsWu6JQr','8tzCRzpIl75ZXONLOJ@gmail.com'),
('Qa2gGVsWu6JQrneUxYvo','xafYUjRIv1EYmQLK4STXcgSA','8OR2cOC05hbcXX@yahoo.com'),
('5smAmQLK4STXcgSAhFi1','xNRxTjPVUdoQOkyVSrLXjPR3b','pyK8Ze8uoxwJeLnc@sis.hust.edu.vn'),
('HOkyVSrLXjPR3b4isiwc','fJUffwmdNHAEVSrLXjPR3b4isiw','VLDw3NRb6chVS5lY@sis.hust.edu.vn')

drop table users

create table 

select * from register

create table personal
(
id int identity(1,1),
name varchar(50),
sex char(1),
age int,
height int,
weight int,
TDEE float,
)


insert into personal (name, age, sex, height, weight,TDEE)
values
('Bui Dieu linh','65','F','197','68',''),
('Chi Van Linh','60','F','134','48',''),
('Ly Thuan Nam','38','M','170','108',''),
('Do Van Son','58','M','187','104',''),
('Thanh Dat','88','M','164','58',''),
('Nguyen Hoai Linh','96','F','130','63',''),
('Nguyen Dieu Anh','52','F','185','120',''),
('Bui Tien Thanh','62','M','170','70',''),
('Pham Thu Trang','39','F','178','105',''),
('Tran Lyn Lyn','16','F','161','60',''),
('Tran Minh Ngoc','67','F','153','48',''),
('Nguyen Thu Giang','29','F','158','54',''),
('Vu Viet Bach','46','M','149','60',''),
('Dong Gang Thep','30','M','157','60',''),
('Nguyen Quoc Anh','11','M','156','41',''),
('Bui Thao Nhi','69','F','164','90',''),
('Bui Hoang Khanh','65','M','140','47',''),
('Tran Hoang Anh','91','F','146','35',''),
('Nguyen Xuan Mai','20','F','150','44',''),
('Nguyen Hoang','76','M','200','110','')

drop table personal
