-- homework 4 design file . booths algorithm 

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity homework_4design is
generic (
input_size		: integer := 8);

port (
product		: out signed(2*input_size-1 downto 0);
data_ready	: out std_logic;
input_1 	: in signed(input_size-1 downto 0);
input_2		: in signed(input_size-1 downto 0);
start		: in std_logic;
reset		: in std_logic;
clk			: in std_logic);

end homework_4design;

 architecture behavior of homework_4design is 
 
		type state_type is(init, load, add_state1, add_state2, only_shift_state, right_shift, done, error);
		signal state, nxt_state	: state_type;
 
 signal add_A_P		: std_logic := '0';
 signal add_S_P		: std_logic := '0';
 
 signal shift		: std_logic := '0';
 
 signal load_data	: std_logic := '0';
 
 -- data signals
 signal A_reg 			: signed(2*input_size downto 0);
 signal S_reg 			: signed(2*input_size downto 0);
 signal product_reg 	: signed(2*input_size downto 0);

 constant maxcount		: integer := input_size-1;

signal count			: integer range 0 to maxcount+1 :=0;
signal start_count_lead	: std_logic := '0';
signal start_count_follow : std_logic := '0';
signal start_count       	: std_logic := '0';
 
 begin 
         -- state machine control process block

		state_proc: process(clk)
			begin
		if rising_edge(clk) then
					if(reset = '0') then
								state <= init;
 		else
			state <= nxt_state;
 
 end if;
 end if;
 end process state_proc;
 -- end of state machine control process
 
 -- now the state machine process steps and input signals...
 state_machine: process(state, start, start_count, count, product_reg(0), product_reg(1))
 
 begin
 
 -- initializing next state and control signals 
 
nxt_state <= state;
 shift <= '0'; add_A_P <= '0';
 
 add_S_P <= '0';
 load_data <= '0'; data_ready <= '0';
 
 case state is
 
		when init =>
				if(start_count = '1') then

				nxt_state <= load;    -- step 1
			else 
				nxt_state <= init;     -- same state
end if;

when load =>

load_data <= '1';

nxt_state <= add_state1;

when add_state1 =>
if(product_reg(1) = '0') then

if(product_reg(0) = '1') then

		add_A_P <= '1';
	nxt_state <= right_shift;
	
	else
	nxt_state <= add_state2;
	end if;
	end if;
when add_state2 =>
	
	if(product_reg(1) = '1') then
if(product_reg(0) = '0') then

		add_S_P <= '1';
		
		nxt_state <= right_shift;
		
else
		
		nxt_state <= only_shift_state;
	
	end if;
		end if;
		
		when only_shift_state =>
		
	if(product_reg(1) = '1') then
	if(product_reg(0) = '1') then

		nxt_state <= right_shift;

	
	elsif(product_reg(1) = '0') then
	elsif(product_reg(0) = '0') then

	nxt_state <= right_shift;

					end if;
end if;

when right_shift =>

		shift <= '1';
		
if(count = maxcount) then          --

--nxt_state <= add_state1;
nxt_state <= done;
else
--nxt_state <= done; --
nxt_state <= add_state1;
end if;

when done =>
data_ready <= '1';

if(start = '0') then
nxt_state <= init;  --
else
nxt_state <= done; --
end if;
when others =>
nxt_state <= error;  --

end case;
end process state_machine;

-- Edge detector for "Start" input

start_count <= start_count_lead and (not start_count_follow);
start_count_proc: process(clk)
begin
if(rising_edge(clk)) then
if(reset = '0') then
start_count_lead <= '0';
start_count_follow <= '0';
else
start_count_lead <= start;
start_count_follow <= start_count_lead;
end if;

end if;
end process start_count_proc;

-- counter is to keep track of the adds and shifts 
count_proc: process(clk)
begin
if(rising_edge(clk)) then
if((start_count = '1') or (reset = '0')) then
count <= 0;
elsif(state = right_shift) then
count <= count + 1;
end if;
end if;
end process count_proc;

homework_4design_proc: process(clk)
begin
if(rising_edge(clk)) then
if(reset = '0') then

product_reg <= (others => '0');    --

--A_reg <= (others => '0');
--S_reg <= (others => '0');


	elsif(load_data = '1') then  --
				--product_reg(2*input_size downto 2*input_size-7) <= ('0'&'0'&'0'&'0'&'0'&'0'&'0'&'0');
				product_reg(2*input_size downto input_size+1) <= ('0'&'0'&'0'&'0'&'0'&'0'&'0'&'0');
				product_reg(input_size downto 1) <= input_1; 
				
				product_reg(0) <= '0';


				--A_reg(2*input_size downto 2*input_size-7) <= input_2;
				A_reg(2*input_size downto input_size+1) <= input_2;
				A_reg(input_size downto 0) <= (others => '0');

				--S_reg(2*input_size downto 2*input_size-7) <=  (not(input_2)) + ('0'&'0'&'0'&'0'&'0'&'0'&'0'&'1');
				S_reg(2*input_size downto input_size+1) <=  (not(input_2)) + ('0'&'0'&'0'&'0'&'0'&'0'&'0'&'1');
				S_reg(input_size downto 0) <= (others => '0');

				
	elsif(add_A_P = '1') then

		product_reg <= product_reg + A_reg;
		
	elsif(add_S_P = '1') then

		product_reg <= product_reg + S_reg;
		
	elsif(shift = '1') then
				product_reg (2*input_size-1 downto 0) <= product_reg(2*input_size downto 1);
			
				
		end if;
	end if;
end process homework_4design_proc;

product <= product_reg(2*input_size downto 1);

end behavior;
