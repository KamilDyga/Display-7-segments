library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter is
	generic(
		c_width	: integer :=6	
	
	);
	port(
		clk		: in std_logic;
		rst_n		: in std_logic;
		ce			: in std_logic;
		dir 		: in std_logic;
		count		: out std_logic_vector(c_width-1 downto 0)
	
		);
end counter;
	
architecture basic of counter is
	signal count_int	: std_logic_vector(c_width-1 downto 0);
	
begin
	
	count <= count_int;
	
	process(clk, rst_n)
	begin
		--tu bedziemy tylko jak bedzie zmiana na clk lub rst
		if rst_n = '0' then
			count_int <= (others => '0');
		elsif rising_edge(clk) and ce = '1' then
			if dir = '1' then 
				count_int <= count_int + 1;
			else
				count_int <= count_int -1;
			
			end if;			
		end if;
	end process;
	
end basic;