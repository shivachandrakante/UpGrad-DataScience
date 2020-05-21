drop schema if exists recipe;

create schema recipe;

use recipe;

drop table if exists recipes;
# creating a new table
create table recipes (
  recipe_id int not null,
  recipe_name varchar(30) not null,
  nothing int not null,
  primary key (recipe_name),
  unique (recipe_id)
);

# inserting values into thee new table
insert into recipes 
    (recipe_id, recipe_name,nothing) 
values 
    (1,"Tacos",4),
    (2,"Tomato Soup",5),
    (3,"Grilled Cheese",4),
    (4,"Something good",6),
    (5,"Something not so good",3),
    (6,"Something wonderful",5);

