CREATE TABLE tbl_autores (
	id_autores SERIAL CONSTRAINT pk_autores PRIMARY KEY,
	Nome_autor varchar(50) NOT NULL,
	Nascionalidade varchar(50) NOT NULL
);

Create table tbl_categoria (
	id_categoria SERIAL CONSTRAINT pk_categoria PRIMARY KEY,
	tipo_categoria varchar(50) NOT NULL
);

Create Table tbl_editora (
	id_editora SERIAL CONSTRAINT pk_editora PRIMARY KEY,
	Nome_editora varchar(50) NOT NULL
);

Create Table tbl_livros (
	isbn_livros SERIAL CONSTRAINT pk_livros PRIMARY KEY,
	titulo_livro varchar(50) NOT NULL,
	ano_publicacao integer NOT NULL,
	editora integer NOT NULL,
	categoria integer NOT NULL,
	FOREIGN KEY (editora) REFERENCES tbl_editora (id_editora),
	FOREIGN KEY (categoria) REFERENCES tbl_categoria (id_categoria)
);	

CREATE TABLE tbl_livroAutor(
	id_livroAutor SERIAL CONSTRAINT pk_livroAutor PRIMARY KEY,
	livro INTEGER NOT NULL,
	autor INTEGER NOT NULL,
	FOREIGN KEY (autor) REFERENCES tbl_autores (id_autores),
	FOREIGN KEY (livro) REFERENCES tbl_livros (isbn_livros)); 
