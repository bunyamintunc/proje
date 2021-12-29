--create database proje_final
/*
create table destekleyenler(
sirket_no int identity (1,1) not null primary key,
sirket_ismi varchar(20),
�lke varchar(10),
)
*/
/*
create table kullan�c�lar(
kullan�c�Id int identity (1,1) not null primary key,
kullan�c�Ad varchar(20),
ismi varchar(20),
soyismi varchar(20),
telNo varchar(20)
)
*/
/*
create table gelisitiriciler(
gelisitiriciNo int identity (1,1) not null primary key,
topluluk_ismi varchar(50),
�lke varchar(20),
bilgi varchar(300)
)
*/
/*
create table algoritma_t�rleri(
algoritma_kodu varchar(20) not null primary key,
byte_uzunluk int,
gelisitiriciNo int,
foreign key(gelisitiriciNo) references gelisitiriciler(gelisitiriciNo),
cikis_tarihi date
)
*/
/*
create table kodlama_dilleri(
dil_Kodu varchar(10) not null primary key,
dil_ad� varchar(20),
cikis_tarihi date,
sirket_no int,
foreign key(sirket_no) references destekleyenler(sirket_no)
)
*/
/*
create table sifrelenmis_metin(
sifrelenen_metinID int identity(1,1) not null primary key,
sifrelenen_metin varchar(300),
algoritma_kodu varchar(20),
foreign key(algoritma_kodu) references algoritma_t�rleri(algoritma_kodu),
dil_Kodu varchar(10),
foreign key(dil_Kodu) references kodlama_dilleri(dil_Kodu),
kullan�c�Id int,
foreign key(kullan�c�Id) references kullan�c�lar(kullan�c�Id),
)
*/
/*
insert into kullan�c�lar values('zet','emre','topal','05511569874')
insert into kullan�c�lar values('bntunc','bunyamin','t�n�','05511568545')
insert into kullan�c�lar values('tlhamrlc','talha','marulcu','05526984521')
insert into kullan�c�lar values('erykrtloglu','eray','kartalo�lu','05589523698')
insert into kullan�c�lar values('slmbrke','selim','ilban','05511545558')
*/
--insert into destekleyenler values('microsoft','amerika')
--insert into destekleyenler values('Python Yaz�l�m Vakf�','amerika')
--insert into destekleyenler values('oracle','amerika')
--insert into destekleyenler values('Mozilla Foundation','amerika')
--insert into destekleyenler values('Google','amerika')

--insert into gelisitiriciler values('Ulusal G�venlik Ajans�','amerika','SHA-2, ABD Ulusal G�venlik Ajans� taraf�ndan tasarlanm�� kriptografik �zet fonksiyonlar� k�mesidir. Kriptografik �zet fonksiyonlar�, hesaplanm�� ��zet� ile bilinen ve beklenen �zet de�erinin kar��la�t�r�lmas�yla, dijital veri �zerinde y�r�yen matematiksel operasyonlard�r.')
--insert into gelisitiriciler values('Ron Rivest','amerika','Ronald Linn Rivest, Amerikal� �ifrebilimci. Massachusetts Teknoloji Enstit�s�nde profes�r olarak g�rev yapmaktad�r.')
--insert into gelisitiriciler values('Dan Bernstein','amerika','Daniel Julius Bernstein, Amerikal� bir Alman matematik�i, kriptolog ve bilgisayar bilimcisidir. Bochum Ruhr �niversitesinde CASAda misafir profes�r ve Chicagodaki Illinois �niversitesinde Bilgisayar Bilimleri Ara�t�rma Profes�r�d�r.')

/*
insert into kodlama_dilleri values('py','python','1990-10-10',2)
insert into kodlama_dilleri values('c#','c sharp','2000-05-11',1)
insert into kodlama_dilleri values('js','javascript','1995-10-10',6)
insert into kodlama_dilleri values('drt','dart','2013-12-12',5)
insert into kodlama_dilleri values('jv','java','1995-08-08',3)
*/

/*
insert into algoritma_t�rleri values('sha-256',32,1,'2004-10-10')
insert into algoritma_t�rleri values('sha-512',32,1,'2008-10-10')
insert into algoritma_t�rleri values('sha-224',32,1,'2008-10-10')
insert into algoritma_t�rleri values('md-5',128,2,'2007-10-10')
insert into algoritma_t�rleri values('blank2b',64,3,'2009-06-09')
insert into algoritma_t�rleri values('blank2s',64,3,'2009-06-09')
insert into algoritma_t�rleri values('rsa',32,2,'2007-06-09')
insert into algoritma_t�rleri values('ferned',64,3,'2010-06-09')
*/
--CASCADING
/*
ALTER TABLE sifrelenmis_metin  WITH CHECK ADD  CONSTRAINT [Fk_cons] FOREIGN KEY([kullan�c�Id])
REFERENCES kullan�c�lar ([kullan�c�Id])
ON DELETE NO ACTION
GO
*/

/*
ALTER TABLE sifrelenmis_metin  WITH CHECK ADD  CONSTRAINT [Fk_cons2] FOREIGN KEY([algoritma_kodu])
REFERENCES algoritma_t�rleri ([algoritma_kodu])
ON DELETE NO ACTION
GO
*/

/*
ALTER TABLE sifrelenmis_metin  WITH CHECK ADD  CONSTRAINT [Fk_cons3] FOREIGN KEY([dil_Kodu])
REFERENCES kodlama_dilleri ([dil_Kodu])
ON DELETE NO ACTION
*/

--CONSTRAINTLER
/*
alter table algoritma_t�rleri add constraint CN_algoritmakodu
unique (algoritma_kodu)
*/

/*
alter table kodlama_dilleri add constraint CN_dil_Kodu
unique (dil_Kodu)
*/

 /*
alter table sifrelenmis_metin add constraint DF_dil_Kodu
default 'py' for dil_Kodu
*/

/*
alter table sifrelenmis_metin add constraint CN_sifrelenen_metin_len
check (len(sifrelenen_metin)>5)
*/

/*
alter table kodlama_dilleri add constraint CN_cikis_tarihi
check (cikis_tarihi<getdate())
*/

--RULES
--create rule rl_uzunluk as len(@value)<=10
--exec sp_bindrule rl_uzunluk,'kodlama_dilleri.dil_Kodu'

--create rule rl_tarih as @value<getdate()
--exec sp_bindrule rl_tarih,'algoritma_t�rleri.cikis_tarihi'


--STORED PROCEDURE

--kullan�c�ID si xxx olan kullan�c�n�n yapt��� hash islemlerini g�steren store procedure
/*
create procedure kullan�c�_arama
(@kullan�c�Id int)
as
select * from sifrelenmis_metin s inner join kullan�c�lar k on s.kullan�c�Id=k.kullan�c�Id where k.kullan�c�Id=@kullan�c�Id
*/
--exec kullan�c�_arama 1

/*
create procedure algoritma_arama
(@AlgoritmaKodu varchar(10))
as
select * from sifrelenmis_metin s join algoritma_t�rleri a on s.algoritma_kodu=a.algoritma_kodu
where a.algoritma_kodu=@AlgoritmaKodu
*/
--exec algoritma_arama 'sha-256'

--VIEW

--python ile yaz�lan kodlar�n �ifrelenen metinlerini g�steren tablo
/*
create view py_yaz�lan
as
select sifrelenen_metin from sifrelenmis_metin s where s.dil_Kodu='py'
*/
--select * from py_yaz�lan

--��k�� tarihi 2000 �ncesi olan kodlama dillerini listeleyen tablo
/*
create view cikis_tarih
as
select * from kodlama_dilleri where year(cikis_tarihi)<2000 
*/
--select * from cikis_tarih

--b�y�kl��� 32 byte �st� olan algoritma t�rlerini listeleyen tablo
/*
create view byte_uzunluk
as
select * from algoritma_t�rleri where byte_uzunluk>32
*/
--select * from byte_uzunluk

--TABLO D�ND�REN FONKS�YON

--kodlama dillerini destekleyen �irketlerin �lkelerine g�re arama yapan fonksiyon
/*
create function search_ulke(@ulke_ismi varchar(20))
returns table
as
return select * from destekleyenler where �lke=@ulke_ismi
*/
--select * from search_ulke('amerika')


--�ifreleme algoritmalar�n�n geli�tiricilerini yazd�ran fonksiyon
/*
create function gelistirici_isim()
returns table
as
return select a.algoritma_kodu,g.topluluk_ismi from gelisitiriciler g inner join algoritma_t�rleri a on g.gelisitiriciNo=a.gelisitiriciNo  
*/
--select * from gelistirici_isim()

--KULLANICI TANIMLI FONKS�YON 

--x kodlama dili ile yaz�lan �ifreleme algoritmalar�n�n t�rlerinin b�y�kl���n�n ortalamas�n� alan fonksiyon
/*
create function ortalama_buyukluk(@kod_dili varchar(10))
   returns int
   as
   begin 
     declare @ortalama int
	 select @ortalama=avg(byte_uzunluk) from algoritma_t�rleri a join sifrelenmis_metin s on a.algoritma_kodu=s.algoritma_kodu 
	 where s.dil_Kodu=@kod_dili
	 return @ortalama
   end
   */
--select dbo.ortalama_buyukluk('py') as 'byte ortalamas�'


--kodlama dillerinin ka� y�ll�k oldu�unu bulan 
/*
create function kac_y�ll�k(@dil_kdu varchar(10))
returns int
as
begin
declare @yil int
select @yil=year(getdate())-year(cikis_tarihi) from kodlama_dilleri where dil_Kodu=@dil_kdu
return @yil
end
*/
--select dbo.kac_y�ll�k('jv') as 'yas'
 
--TRIGGER

/*
create trigger ekleme
on kullan�c�lar
after insert 
as 
begin 
       select 'yeni kullan�c� eklendi'
end
*/
--insert into kullan�c�lar values('odemirbas','osman','demirbas','05511564587')