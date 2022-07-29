INSERT INTO t_member_authorities_code(member_authorities_code_seq,authority, register_date ) VALUES(1,'ROLE_ADMIN','2020-01-01');
INSERT INTO t_member_authorities_code(member_authorities_code_seq,authority, register_date ) VALUES(2,'ROLE_MEMBER','2020-01-01');

INSERT INTO t_member_info(member_info_seq, member_email, member_id, member_password,register_date, update_date, delete_date) VALUES(1,'admin@naver.com','admin' ,'$2a$10$hKDVYxLefVHV/vtuPhWD3OigtRyOykRLDdUAp80Z1crSoS1lFqaFS','2020-01-01',null,null );
INSERT INTO t_member_authorities_mapping(member_authorities_mapping_seq ,member_info_seq, member_authorities_code_seq) VALUES(1,1,1);
INSERT INTO t_member_authorities_mapping(member_authorities_mapping_seq ,member_info_seq, member_authorities_code_seq) VALUES(2,1,2);
