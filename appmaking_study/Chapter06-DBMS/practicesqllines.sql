INSERT INTO department (depart_title, depart_addr) VALUES ('인사팀', '201호');
INSERT INTO department (depart_title, depart_addr) VALUES ('재무팀', '202호');
INSERT INTO department (depart_title, depart_addr) VALUES ('마케팅팀', '305호');
INSERT INTO department (depart_title, depart_addr) VALUES ('영업팀', '205호');

UPDATE department SET 
	depart_title = 'B2B사업팀', 
	depart_addr = '210호'
WHERE depart_cd = 4;

DELETE FROM department
WHERE depart_cd = 4;

SELECT depart_cd, depart_title, depart_addr
FROM department
ORDER BY depart_cd DESC, depart_title ASC