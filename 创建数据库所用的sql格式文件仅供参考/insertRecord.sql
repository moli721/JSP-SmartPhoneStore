use mobileDatabase;
insert into mobileClassify values
           (1,'iOS手机'), 
           (2,'Android手机');
insert into mobileForm values
           ('A2345','Apple iPhone 12 Pro','苹果公司',8999,'256G 暗夜蓝','apple3.jpg',1),
           ('A2456','Apple iPhone 13','苹果公司',6999,'128G 星光色','apple4.jpg',1),
           ('A2567','Apple iPhone SE','苹果公司',3999,'64G 黑色','apple5.jpg',1),
           ('HW789','Huawei Nova 8','华为公司',3298,'128G 绮境森林','huawei3.jpg',2),
           ('HW890','Huawei Nova 9 Pro','华为公司',3999,'256G 星际蓝','huawei4.jpg',2),
           ('HW901','Huawei Mate 40','华为公司',6499,'256G 秋日胡杨','huawei5.jpg',2),
           ('XM234','小米11 Ultra','小米公司',5999,'256G 陶瓷黑','xiaomi3.jpg',2),
           ('XM345','Redmi K40','小米公司',2499,'128G 幻境','xiaomi4.jpg',2),
           ('XM456','POCO F3','小米公司',2799,'256G 暗夜黑','xiaomi5.jpg',2),
           ('OP123','OPPO Find X3','OPPO公司',4499,'256G 镜黑','oppo1.jpg',2),
           ('OP234','OPPO Reno6 Pro','OPPO公司',3499,'128G 夏日星','oppo2.jpg',2),
           ('OP345','OPPO A95','OPPO公司',1799,'128G 炫彩银','oppo3.jpg',2),
           ('VS123','vivo X70 Pro','vivo公司',4498,'256G 黑翼','vivo1.jpg',2),
           ('VS234','vivo S10 Pro','vivo公司',2999,'128G 青柠','vivo2.jpg',2),
           ('VS345','vivo Y73','vivo公司',1799,'128G 极光','vivo3.jpg',2),
           ('SS123','Samsung S21 Ultra','三星公司',7999,'256G 幻境银','samsung1.jpg',2),
           ('SS234','Samsung Note 20','三星公司',6999,'256G 迷雾金','samsung2.jpg',2),
           ('SS345','Samsung A52','三星公司',2599,'128G 炫目黑','samsung3.jpg',2);
select * from mobileClassify;
select * from mobileForm; 

  