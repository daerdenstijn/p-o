library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity clock_recov_tb is
end clock_recov_tb;
 
architecture behave of clock_recov_tb is
  
  	signal clk: std_logic := '0';
   signal data_in: std_logic_vector(2 downto 0);
   signal rx_data: std_logic_vector(2 downto 0);
  
   constant clocks_per_bit : integer := 16;
   constant osr : integer := 2;	
	constant clk_period : time := 24000 ns;
   constant c_BIT_PERIOD : time := clk_period*osr;
   
  
   signal input : std_logic_vector (2 downto 0) := "000";
   
begin
	clock_recovery: entity work.clock_recovery port map(
		clk => clk,
		data_in => input,
		rx_data => rx_data
	);
	
	-- clock process
	process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;

 
   -- stimulus process
	process
	begin
		
	 -- Send Start Bit
		input <= "001";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
 
	 -- Send Data
	
		input <= "001";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
		input <= "011";
		wait for clk_period;
		input <= "011";
		wait for clk_period;
		input <= "111";
		wait for clk_period;
		input <= "101";
		wait for clk_period;
		input <= "110";
		wait for clk_period;
		input <= "110";
		wait for clk_period;
		input <= "101";
		wait for clk_period;
		input <= "101";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
		
	-- Send Stop Bit
		input <= "001";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
		input <= "001";
		wait for clk_period;
		
	end process;
 

END;

