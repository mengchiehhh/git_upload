--drop table police;
--create table police(code CHAR(4) primary key,
--                    locat NVARCHAR2(200),
--                    address NVARCHAR2(200),
--                    tel VARCHAR2(20));
--insert into police(code, locat, address, tel)
--values ('M001', '�˫n����', '	�]�߿��˫n����ڵ�72��', '03 747 4796');
--insert into police(code, locat, address, tel)
--values ('M002', '�]�ߤ���', '�]�߿��]�ߥ������109��', '03 732 0059');
--insert into police(code, locat, address, tel)
--values ('M003', '�Y������', '�]�߿��Y����������503��',	'03 766 3004');

--drop table village;
--create table village(code CHAR(4) primary key,
--                    locat NVARCHAR2(200),
--                    address NVARCHAR2(200),
--                    tel VARCHAR2(20),
--                    pcode CHAR(4) references police(code));
--insert into village(code, locat, address, tel, pcode)
--values('C001', '�j�H��', '�˫n���q��1035��', '03 758 1072', 'M001');
--insert into village(code, locat, address, tel, pcode)
--values('C002', '�˫n��', '�˫n��˫n�����s�� 103 ��', '037-472735', 'M001');
--insert into village(code, locat, address, tel, pcode)
--values('C003', '�s�Ψ�', '�˫n��s�Ψ������ 14 ��', '037-614186', 'M001');
--insert into village(code, locat, address, tel, pcode)
--values('C004', '�H����', '���s��H����������136-1��', '037-724839', 'M001');
--insert into village(code, locat, address, tel, pcode)
--values('C005', '��]��', '�]�ߥ���]�������� 766 ��', '037-333240', 'M002');
--insert into village(code, locat, address, tel, pcode)
--values('C006', '���ڨ�', '���ڨ����ڸ�96��', '037-660001', 'M003');
--insert into village(code, locat, address, tel, pcode)
--values('C007', '������', '���������j��82��', '037-661145', 'M003');
--insert into village(code, locat, address, tel, pcode)
--values('C008', '�H�q��', '�H�q���H�q��53��1��', '037-616072', 'M003');

--drop table facility;
--create table facility(vcode CHAR(4) references village(code),
--                    cate NVARCHAR2(200),
--                    address NVARCHAR2(200) primary key,
--                    people INT,
--                    unfloor INT, 
--                    pcode CHAR(4) references police(code));
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C001', '���J', '�]�߿��˫n���H��20��', 100, 1, 'M001');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C002', '�j��', '�]�߿��˫n��M����79��', 3142, 1, 'M001');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C003', '�j��', '�]�߿��˫n���s�s���T�q142��', 1072, 1, 'M001');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C004', '���@�]�I', '�]�߿����s���ظ�1498��', 32, 1, 'M001');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C005', '���J', '�]�߿��]�ߥ��̥���80��', 106, 1, 'M002');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C005', '���J', '�]�߿��]�ߥ����_��117��', 26, 1, 'M002');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C005', '�j��', '�]�߿��]�ߥ��շR��109��', 2038, 2, 'M002');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C005', '�j��', '�]�߿��]�ߥ��j�P��53��', 128, 2, 'M002');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C006', '���@�]�I', '�]�߿��Y�������ڨ��M����102��', 353, 1, 'M003');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C007', '�p����', '�]�߿��Y�������������@��69��', 501, 1, 'M003');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C008', '���J', '�]�߿��Y�����H�q��������65��', 194, 1, 'M003');
--insert into facility(vcode, cate, address, people, unfloor, pcode)
--values('C008', '�p����', '�]�߿��Y�����H�q��������116��', 78, 1, 'M003');

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
where facility.address like '%��%';

-- 4-5
select village.locat, village.address as vaddress, 
        facility.address as faddress, facility.people
from village
full outer join facility on village.code = facility.vcode
where facility.cate in ('���J', '�j��');

-- 5-1
update facility
set people = 5000
where address = '�]�߿��˫n��M����79��';

-- 5-2
delete from facility where people < 1000;

select * from police p;










