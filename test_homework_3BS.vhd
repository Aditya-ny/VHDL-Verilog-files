-- test for hw3 barrel shifter
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use std.textio.all;
use IEEE.std_logic_textio.all;

use work.sim_mem_init.all;

entity test_homework_3BS is
end;

architecture test of test_homework_3BS is

component desgin_homework_3BS
    generic (
	
	bit_depth : integer := 8);
port(
A		: out std_logic_vector(bit_depth-1 downto 0);
I 		: in std_logic_vector(bit_depth-1 downto 0);
S 		: in std_logic_vector(1 downto 0);
shift	: in integer range 0 to bit_depth-1;
reset	: in std_logic;
clk 	: in std_logic);
end component;

constant data_width	: integer :=8;
signal data_in		: std_logic_vector(data_width-1 downto 0);
signal data_out			: std_logic_vector(data_width-1 downto 0);
signal expected			: std_logic_vector(data_width-1 downto 0);
signal sel			: std_logic_vector(1 downto 0);
signal clk			: std_logic := '1';
signal reset		: std_logic := '1';

signal shift : integer range 0 to data_width-1;
constant in_fname		: string := "input.csv";
constant out_fname		: string := "output.csv";
file input_file				: text;
file output_file			: text;

begin

dev_to_test: desgin_homework_3BS

generic map(data_width)
port map(data_out, data_in, sel, shift, reset, clk);
		
stimulus: process

variable input_line	: line;
variable WriteBuf	: line;
variable in_char	: character;
variable in_slv		: std_logic_vector(7 downto 0);
variable out_slv	:std_logic_vector(7 downto 0);

variable ErrCnt		: integer := 0;
begin

file_open(input_file, in_fname, read_mode);

file_open(output_file, out_fname, read_mode);


while not(endfile(input_file)) loop
readline(input_file, input_line);

for i in 0 to 8 loop       		 --   


read(input_line,in_char);
	in_slv := std_logic_vector(to_unsigned(character'pos(in_char),8));
	
	if( i = 3) then
	data_in(7 downto 4) <= ASCII_to_hex(in_slv);
	elsif(i = 4) then
	data_in(3 downto 0) <= ASCII_to_hex(in_slv);
	elsif (i = 6) then
	sel <= in_slv(1 downto 0);
	elsif( i = 8) then
	 
	shift <= to_integer(signed(in_slv(2 downto 0)));  
	end if;
	end loop;
	
	readline(output_file,input_line);
	
	clk <= '0';
	wait for 10 ns;
	
	for i in 0 to 4 loop
	read(input_line, in_char);
	out_slv := std_logic_vector(to_unsigned(character'pos(in_char),8));
	
	if (i =3) then
	expected(7 downto 4) <= ASCII_to_hex(out_slv);
	elsif( i =4) then
	expected(3 downto 0) <= ASCII_to_hex(out_slv);
	end if;
	end loop;
	
	clk <= '1';
	wait for 10 ns;
	
	if (expected /= data_out) then
	write(WriteBuf, string'(" ERROR barrel shifter failed    "));
	write(WriteBuf, string'("   expected = "));
	write(WriteBuf, expected);
	write(WriteBuf, string'(", data_out = "));
	write(WriteBuf, data_out);
	
	writeline(Output, WriteBuf);
	ErrCnt := ErrCnt+1;
	end if;
	end loop;
	
	file_close(input_file);
	file_close(output_file);
	
	if(ErrCnt = 0) then
	report "Success. The barrel shifter test is completed";
	else
	report "The barrel shifter is broken" severity warning;
	end if;
	end process stimulus;
	end test;
	