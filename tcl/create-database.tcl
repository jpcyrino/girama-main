package require sqlite3

sqlite3 db girama
db eval {CREATE TABLE language(glottocode text not null primary key, 
						       name text not null, 
							   region text, 
							   speakers int, 
							   description text)}

db eval {CREATE TABLE ocun_source (ocun_source_id text not null primary key,
								   glottocode text not null,
								   name text not null,
								   author text,
								   year int,
								   license text)}
							   
db eval {CREATE TABLE ocun (phrase_id text not null primary key, 
							glottocode text not null, 
							source text not null, 
							phrase text not null, 
							gloss text not null, 
							translation text not null, 
							FOREIGN KEY(glottocode) REFERENCES language(glottocode))}

db eval {CREATE TABLE yiri_type(type_id text not null primary key,
								name text not null, 
								table_name text not null, 
								info text)}
								
								
db eval {CREATE TABLE yiri(yiri_id text not null primary key, 
						   type text not null, 
						   identifier text not null, 
						   glottocode text not null, 
						   text text not null)}
						   
db eval {CREATE TABLE typology(typology_id text not null primary key,
							   source text not null,
							   glottocode text not null, 
							   parameter text not null, 
							   value text)}
							   
db eval {CREATE TABLE typology_source(typology_source_id text not null primary key, 
									  name text not null, 
									  info text)}

db eval {CREATE TABLE typology_parameter(typology_parameter_id text not null primary key,
										 name text not null,
										 info text)}
										 
db eval {CREATE TABLE bible(bible_id text not null primary key,
							book text not null,
							chapter int not null, 
							verse int not null)}


db close
