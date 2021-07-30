library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
ENTITY get_data_tb IS
END get_data_tb;
 
ARCHITECTURE behavior OF get_data_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT get_data
    PORT(
			clk: in std_logic; 	
         data_out : out integer range -33000 to 33000
        );
    END COMPONENT;
    

   --Inputs
   --signal position : integer := 0;
	signal clk : std_logic := '0';
 	--Outputs
   signal data_out : integer range -33000 to 33000 := 0; 
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: get_data PORT MAP (
         -- position => position,
			 clk => clk,
          data_out => data_out
        );

   -- Clock process definitions
   clock_process :process
   begin
		clk <= '0';
		wait for clock_period/2;
		clk <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
