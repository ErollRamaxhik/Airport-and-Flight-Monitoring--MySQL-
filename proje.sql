-- CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE `My_schema`.`AIRPLANE`(
Airplane_id int NOT NULL,
Total_number_of_seats int NOT NULL,
Airplane_type varchar(20),
 PRIMARY KEY(Airplane_id),
 CONSTRAINT `fk_AIRPLANE_1`
  FOREIGN KEY (`Airplane_type`)
  REFERENCES `My_schema`.`AIRPLANE_TYPE` (`Airplane_type_name`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE `My_schema`.`AIRPLANE_TYPE`(
Company varchar(15) NOT NULL,
Max_seats int NOT NULL,
Airplane_type_name varchar(20) NOT NULL,
 PRIMARY KEY(Airplane_type_name)
);

CREATE TABLE `My_schema`.`AIRPORT`(
 Airport_code varchar(3) NOT NULL,
 City varchar(30) NOT NULL,
 Airport_name varchar(30) NOT NULL,
 State varchar(30),
  PRIMARY KEY(Airport_code)
);

CREATE TABLE `My_schema`.`CAN_LAND`(
 Airplane_type_name varchar(20) NOT NULL,
 Airport_code varchar(3) NOT NULL,
  PRIMARY KEY(Airplane_type_name,Airport_code),
  CONSTRAINT `fk_CAN_LAND_1`
  FOREIGN KEY (`Airplane_type_name`)
  REFERENCES `My_schema`.`AIRPLANE_TYPE` (`Airplane_type_name`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
 CONSTRAINT `fk_CAN_LAND_2`
  FOREIGN KEY (`Airport_code`)
  REFERENCES `My_schema`.`AIRPORT` (`Airport_code`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE `My_schema`.`FARE`(
 Flight_number varchar(6) NOT NULL,
 Fare_code varchar(10) NOT NULL,
 Amount decimal(8,2) NOT NULL,
 Restrictions varchar(200),
 PRIMARY KEY(Flight_number,Fare_code),
 CONSTRAINT `fk_FARE_1`
  FOREIGN KEY (`Flight_number`)
  REFERENCES `My_schema`.`FLIGHT` (`Flight_number`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE `My_schema`.`FLIGHT`(
 Flight_number varchar(6) NOT NULL,
 Airline varchar(20) NOT NULL,
 Weekdays varchar(10) NOT NULL,
 PRIMARY KEY(Flight_number)
);

CREATE TABLE `My_schema`.`FLIGHT_LEG`(
 Flight_number varchar(6) NOT NULL,
 Leg_number int NOT NULL,
 Departure_airport_code varchar(3) NOT NULL,
 Scheduled_departure_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 Arrival_airport_code varchar(3) NOT NULL,
 Scheduled_arrival_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY(Flight_number,Leg_number),
 CONSTRAINT `fk_FLIGHT_LEG_1`
  FOREIGN KEY (`Flight_number`)
  REFERENCES `My_schema`.`FLIGHT` (`Flight_number`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
 CONSTRAINT `fk_FLIGHT_LEG_2`
  FOREIGN KEY (`Departure_airport_code`)
  REFERENCES `My_schema`.`AIRPORT` (`Airport_code`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
 CONSTRAINT `fk_FLIGHT_LEG_3`
  FOREIGN KEY (`Arrival_airport_code`)
  REFERENCES `My_schema`.`AIRPORT` (`Airport_code`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE `My_schema`.`LEG_INSTANCE`(
 Flight_number varchar(6) NOT NULL,
 Leg_number int NOT NULL,
 Leg_date date NOT NULL,
 Number_of_available_seats int,
 Airplane_id int NOT NULL,
 Departure_airport_code varchar(3),
 Departure_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 Arrival_airport_code varchar(3),
 Arrival_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY(Flight_number,Leg_number,Leg_date),
 CONSTRAINT `fk_LEG_INSTANCE_1`
  FOREIGN KEY (`Flight_number` , `Leg_number`)
  REFERENCES `My_schema`.`FLIGHT_LEG` (`Flight_number` , `Leg_number`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
 CONSTRAINT `fk_LEG_INSTANCE_2`
  FOREIGN KEY (`Airplane_id`)
  REFERENCES `My_schema`.`AIRPLANE` (`Airplane_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
 CONSTRAINT `fk_LEG_INSTANCE_3`
  FOREIGN KEY (`Departure_airport_code`)
  REFERENCES `My_schema`.`AIRPORT` (`Airport_code`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
 CONSTRAINT `fk_LEG_INSTANCE_4`
  FOREIGN KEY (`Arrival_airport_code`)
  REFERENCES `My_schema`.`AIRPORT` (`Airport_code`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE `My_schema`.`SEAT_RESERVATION`(
 Flight_number varchar(6) NOT NULL,
 Leg_number int NOT NULL,
 Leg_date date NOT NULL,
 Seat_number varchar(4),
 Customer_name varchar(30) NOT NULL,
 Customer_phone varchar(12),
 PRIMARY KEY(Flight_number,Leg_number,Leg_date,Seat_number),
 CONSTRAINT `fk_SEAT_RESERVATION_1`
  FOREIGN KEY (`Flight_number` , `Leg_number` , `Leg_date`)
  REFERENCES `My_schema`.`LEG_INSTANCE` (`Flight_number` , `Leg_number` , `Leg_date`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

SET FOREIGN_KEY_CHECKS=0;
SET FOREIGN_KEY_CHECKS=1;

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

insert into AIRPLANE values('35207','250','AirbusA320');
insert into AIRPORT values('123','Izmir','Adnan Menderes','Ege');
insert into AIRPLANE_TYPE values('Pegasus','250','AirbusA320');
insert into CAN_LAND values('AirbusA320','123'); 
insert into FARE values('12','001881','850','Restriction........');
insert into FLIGHT values('12','Pegasus','Cumartesi');
insert into FLIGHT_LEG values('12','101','123','2017-12-28 08:30:00','121','2017-12-28 09:30:00');
insert into LEG_INSTANCE value('12','101','2017-12-28','2','35207','123','2017-12-28 08:30:00','121','2017-12-28 09:30:00');
insert into SEAT_RESERVATION values('12','101','2017-12-28','27F','John Lennon','905072673970');

SELECT * FROM AIRPLANE;
SELECT * FROM AIRPLANE_TYPE;
SELECT * FROM AIRPORT;
SELECT * FROM CAN_LAND;
SELECT * FROM FARE;
SELECT * FROM FLIGHT;
SELECT * FROM FLIGHT_LEG;
SELECT * FROM LEG_INSTANCE;
SELECT * FROM SEAT_RESERVATION;

update AIRPLANE_TYPE 
set Max_seats='240'
where Airplane_type_name='AirbusA320';

delete from AIRPLANE_TYPE
where Airplane_type_name='AirbusA300';

delete from AIRPLANE
where Airplane_type='AirbusA300';



