--drop table police;
--create table police(code CHAR(4) primary key,
--                    locat NVARCHAR2(200),
--                    address NVARCHAR2(200),
--                    tel VARCHAR2(20));
--insert into police(code, locat, address, tel)
--values ('M001', '竹南分局', '	苗栗縣竹南鎮民族街72號', '03 747 4796');
--insert into police(code, locat, address, tel)
--values ('M002', '苗栗分局', '苗栗縣苗栗市金鳳街109號', '03 732 0059');
--insert into police(code, locat, address, tel)
--values ('M003', '頭份分局', '苗栗縣頭份市中興路503號',	'03 766 3004');

--drop table village;
--create table village(code CHAR(4) primary key,
--                    locat NVARCHAR2(200),
--                    address NVARCHAR2(200),
--                    tel VARCHAR2(20),
--                    pcode CHAR(4) references police(code));
--insert into village(code, locat, address, tel, pcode)
--values('C001', '大埔里', '竹南鎮公義路1035號', '03 758 1072', 'M001');
--insert into village(code, locat, address, tel, pcode)
--values('C002', '竹南里', '竹南鎮竹南里中山路 103 號', '037-472735', 'M001');
--insert into village(code, locat, address, tel, pcode)
--values('C003', '山佳里', '竹南鎮山佳里國光街 14 號', '037-614186', 'M001');
--insert into village(code, locat, address, tel, pcode)
--values('C004', '埔頂里', '後龍鎮埔頂里中興路136-1號', '037-724839', 'M001');
--insert into village(code, locat, address, tel, pcode)
--values('C005', '綠苗里', '苗栗市綠苗里中正路 766 號', '037-333240', 'M002');
--insert into village(code, locat, address, tel, pcode)
--values('C006', '民族里', '民族里民族路96號', '037-660001', 'M003');
--insert into village(code, locat, address, tel, pcode)
--values('C007', '忠孝里', '忠孝里光大街82號', '037-661145', 'M003');
--insert into village(code, locat, address, tel, pcode)
--values('C008', '信義里', '信義里信義路53巷1號', '037-616072', 'M003');

--drop table facility;
--create table facility(vcode CHAR(4) references village(code),
--                    cate NVARCHAR2(200),
--                    address NVARCHAR2(200) primary key,
--                    people INT,
--                    unfloor INT, 
--                    pcode CHAR(4) references police(code));
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C001', '公寓', '苗栗縣竹南鎮中埔街20號', 100, 1, 'M001');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C002', '大樓', '苗栗縣竹南鎮和平街79號', 3142, 1, 'M001');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C003', '大樓', '苗栗縣竹南鎮龍山路三段142號', 1072, 1, 'M001');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C004', '公共設施', '苗栗縣後龍鎮中華路1498號', 32, 1, 'M001');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C005', '公寓', '苗栗縣苗栗市米市街80號', 106, 1, 'M002');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C005', '公寓', '苗栗縣苗栗市光復路117號', 26, 1, 'M002');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C005', '大樓', '苗栗縣苗栗市博愛街109號', 2038, 2, 'M002');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C005', '大樓', '苗栗縣苗栗市大同路53號', 128, 2, 'M002');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C006', '公共設施', '苗栗縣頭份市民族里和平路102號', 353, 1, 'M003');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C007', '私營單位', '苗栗縣頭份市忠孝忠孝一路69號', 501, 1, 'M003');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C008', '公寓', '苗栗縣頭份市信義里中正路65號', 194, 1, 'M003');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C008', '私營單位', '苗栗縣頭份市信義里中正路116號', 78, 1, 'M003');

-- 4-1
select distinct locat, tel 
from police 
left join facility on police.code = facility.pcode
where facility.people > 1000;

-- 4-2
select distinct police.locat, police.tel, 
                count(*) over(partition by police.locat order by police.locat) as pnum
from police 
full outer join facility on police.code = facility.pcode
where facility.people > 1000;

-- 4-3
select distinct police.locat, police.tel, 
                count(*) over(partition by police.locat order by police.locat) as pnum, 
                facility.address, facility.cate
from police 
full outer join facility on police.code = facility.pcode
where facility.people > 1000;

-- 4-4
select village.locat, facility.address, facility.people, police.locat, police.tel
from village
full outer join facility on village.code = facility.vcode
full outer join police on police.code = facility.pcode
where facility.address like '%中%';

-- 4-5
select village.locat, village.address as vaddress, 
        facility.address as faddress, facility.people
from village
full outer join facility on village.code = facility.vcode
where facility.cate in ('公寓', '大樓');

-- 5-1
update facility
set people = 5000
where address = '苗栗縣竹南鎮和平街79號';

-- 5-2
delete from facility where people < 1000;

select * from police p;










