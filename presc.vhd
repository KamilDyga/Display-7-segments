library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity presc is
	port(
		clk		: in std_logic;
		rst_n		: in std_logic;
		ce			: out std_logic
	);
end presc;
	
architecture basic of presc is
	signal count_int	: std_logic_vector(25 downto 0);
begin	
	process(clk, rst_n)
	begin
		--tu bedziemy tylko jak bedzie zmiana na clk lub rst
		if rst_n = '0' then
			count_int <= (others => '0');
		elsif rising_edge(clk) then
			if count_int < (10000000-1) then
				count_int <= count_int + 1;
				ce <= '0';
			else
				count_int <= (others => '0');
				ce <= '1';
			end if;
		end if;
	end process;
	
end basic;
