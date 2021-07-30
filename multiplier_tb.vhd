
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY multiplier_tb IS
END multiplier_tb;
 
ARCHITECTURE behavior OF multiplier_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT multiplexer
    PORT(
         mult_in : IN  std_logic_vector(2 downto 0);
         osc_in : IN  std_logic_vector(2 downto 0);
         mult_out : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal mult_in : std_logic_vector(2 downto 0) := (others => '0');
   signal osc_in : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal mult_out : std_logic_vector(2 downto 0);
 
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: multiplexer PORT MAP (
          mult_in => mult_in,
          osc_in => osc_in,
          mult_out => mult_out
        );

   -- Clock process definitions
--   clock_process :process
--   begin
--		clock <= '0';
--		wait for clock_period/2;
--		clock <= '1';
--		wait for clock_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		osc_in <= "011";
		mult_in <= "111";
      wait for clock_period*10;
		osc_in <= "111";
		mult_in <= "011";
      wait for clock_period*10;
		osc_in <= "101";
		mult_in <= "001";
      wait for clock_period*10;
		osc_in <= "100";
		mult_in <= "011";
      wait for clock_period*10;
		osc_in <= "001";
		mult_in <= "100";
      wait for clock_period*10;
      -- insert stimulus here 

      wait;
   end process;

END;
