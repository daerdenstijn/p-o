
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
 
ENTITY nco_tb IS
END nco_tb;
 
ARCHITECTURE behavior OF nco_tb IS 
 
    COMPONENT nco
    PORT(
         clk : IN  std_logic;
         reset_phase : IN  std_logic;
         nco_in : IN  std_logic_vector(23 downto 0);
         nco_sin : OUT  std_logic_vector(2 downto 0);
			nco_cos : OUT  std_logic_vector(2 downto 0)

        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset_phase : std_logic := '0';
   signal nco_in : std_logic_vector(23 downto 0) := (others => '0');

 	--Outputs
   signal nco_sin : std_logic_vector(2 downto 0);
	signal nco_cos : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nco PORT MAP (
          clk => clk,
          reset_phase => reset_phase,
          nco_in => nco_in,
          nco_sin => nco_sin,
			 nco_cos => nco_cos
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		reset_phase <= '0';
      wait for clk_period;
		reset_phase <= '1';
		nco_in <= std_logic_vector(to_unsigned(16777,24));
		wait for clk_period*5000;
		reset_phase <= '0';
		wait for clk_period;
		reset_phase <= '1';
		nco_in <= std_logic_vector(to_unsigned(16777,24));		
		wait for clk_period*5000;
		reset_phase <= '0';
		wait for clk_period;
		reset_phase <= '1';
		nco_in <= std_logic_vector(to_unsigned(16777,24));		
		wait for clk_period*5000;
		reset_phase <= '0';
		wait for clk_period;
   end process;

END;
