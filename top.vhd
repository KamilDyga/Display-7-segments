library ieee;

use ieee.std_logic_1164.all;

entity top is
	port(
		L			: in  std_logic; 
		R			: in std_logic;
		Res		: in std_logic;
		clk		: in std_logic;
		rst_n		: in std_logic;
		count		: out std_logic_vector(3 downto 0);
		segment	: out std_logic_vector(7 downto 0);
		disp		: out std_logic_vector(3 downto 0)
		
	
	);
end top;
	
architecture basic of top is
	signal count_int : std_logic_vector(3 downto 0);
	signal ce  : std_logic;
	signal ce1 : std_logic;
	signal ce2 : std_logic;
	signal dir : std_logic;
	
	 component counter is
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
	end component counter;
	
	component presc is
		port(
			clk		: in std_logic;
			rst_n		: in std_logic;
			ce			: out std_logic
		);
	end component presc;
	
	component debounce is
		generic(
			debounce_time	: integer :=200000	
		
		);
		
		port(
			clk		: in std_logic;
			pin		: in std_logic;
			pout 		: out std_logic;
			f_edge   : out std_logic
			);
	end component debounce;
	
	component decoder is 
	port(
		
		digit		: in std_logic_vector(3 downto 0);
		segment	: out std_logic_vector(6 downto 0)
	
	);
	end component decoder;
	
begin
	count <= not count_int;
	
	d1: debounce
		port map(
			clk		=> clk,
			pin		=> L,
			pout 		=> dir,
			f_edge   => ce1
			);
			
	d2: debounce
		port map(
			clk		=> clk,
			pin		=> R,
			pout 		=> open,
			f_edge   => ce2
			);
			
	d3: decoder
		port map(
			segment	=> segment(6 downto 0),
			digit		=> count_int
			);
			
	segment(7) <= '0';
	
	disp <= "0110";
	
	ce <= ce1 or ce2;
	
	c1: counter
	
	generic map(
			c_width	=> 4
		
	)
	
	port map(
	
			clk		=> clk,
			rst_n		=> Res,
			ce			=> ce,
			dir		=> dir,
			count		=> count_int
	
	);
	
	
	
end basic;
