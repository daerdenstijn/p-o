
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY agctbe IS
END agctbe;
 
ARCHITECTURE behavior OF agctbe IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT agc
    PORT(
         clk : IN  std_logic;
         adj : OUT  std_logic_vector(6 downto 0);
         agc_out : OUT  std_logic_vector(4 downto 0);
         agc_in : IN  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal agc_in : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal adj : std_logic_vector(6 downto 0);
   signal agc_out : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: agc PORT MAP (
          clk => clk,
          adj => adj,
          agc_out => agc_out,
          agc_in => agc_in
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
		agc_in <= "00000";
      wait for clk_period*10;
		agc_in <= "00000";
      wait for clk_period*10;
		agc_in <= "00000";
      wait for clk_period*10;
		agc_in <= "11000";
		wait for clk_period*10;
		agc_in <= "11000";
		wait for clk_period*10;
		agc_in <= "11000";
      wait for clk_period*10;
		agc_in <= "00000";
      wait for clk_period*10;
		agc_in <= "00000";
      wait for clk_period*10;
		agc_in <= "00000";
      wait for clk_period*10;
		agc_in <= "00000";
      wait for clk_period*10;
		agc_in <= "11000";
		wait for clk_period*10;
		agc_in <= "11000";
		wait for clk_period*10;
		agc_in <= "11000";
      wait for clk_period*10;
		agc_in <= "11000";
		wait for clk_period*10;
		agc_in <= "11000";
		wait for clk_period*10;
		agc_in <= "11000";
      wait for clk_period*10;
      -- insert stimulus here 

      wait;
   end process;

END;
