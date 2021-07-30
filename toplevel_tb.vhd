
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
 
ENTITY toplevel_tb IS
END toplevel_tb;
 
ARCHITECTURE behavior OF toplevel_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT toplevel
    PORT(
         clk_ext : IN  std_logic;
         test_switches : IN  std_logic_vector(3 downto 0);
         test_buttons : IN  std_logic_vector(3 downto 0);
         test_leds : OUT  std_logic_vector(7 downto 0);
         uart_rx : IN  std_logic;
         uart_tx : OUT  std_logic;
         uart_rts_bar : OUT  std_logic;
         uart_cts_bar : IN  std_logic;
         display_digits : OUT  std_logic_vector(3 downto 0);
         display_segments : OUT  std_logic_vector(6 downto 0);
         display_colon : OUT  std_logic;
         analog_comp : IN  std_logic_vector(5 downto 0);
			nco_in : in std_logic_vector(23 downto 0);
			input_d : in integer range -33000 to 33000;
			reset_phase : IN  std_logic;
         analog_gain : OUT  std_logic_vector(5 downto 0);
			rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_ext : std_logic := '0';
   signal test_switches : std_logic_vector(3 downto 0) := (others => '0');
   signal test_buttons : std_logic_vector(3 downto 0) := (others => '0');
   signal uart_rx : std_logic := '0';
   signal uart_cts_bar : std_logic := '0';
   signal analog_comp : std_logic_vector(5 downto 0) := (others => '0');
	signal nco_in : std_logic_vector(23 downto 0) := (others => '0');
	signal input_d : integer range -33000 to 33000:=0;
	signal reset_phase : std_logic := '0';
	signal rst : std_logic := '0';
 	--Outputs
   signal test_leds : std_logic_vector(7 downto 0);
   signal uart_tx : std_logic;
   signal uart_rts_bar : std_logic;
   signal display_digits : std_logic_vector(3 downto 0);
   signal display_segments : std_logic_vector(6 downto 0);
   signal display_colon : std_logic;
   signal analog_gain : std_logic_vector(5 downto 0);
	
   -- Clock period definitions
   constant clk_ext_period : time := 20 ns;
	
	signal waveform_reader_data: std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: toplevel PORT MAP (
          clk_ext => clk_ext,
          test_switches => test_switches,
          test_buttons => test_buttons,
          test_leds => test_leds,
          uart_rx => uart_rx,
          uart_tx => uart_tx,
          uart_rts_bar => uart_rts_bar,
          uart_cts_bar => uart_cts_bar,
          display_digits => display_digits,
          display_segments => display_segments,
          display_colon => display_colon,
          analog_comp => analog_comp,
			 nco_in => nco_in,
			 input_d => input_d,
			 rst => rst,
			 reset_phase => reset_phase,
          analog_gain => analog_gain
        );

   -- Clock process definitions
   clk_ext_process :process
   begin
		clk_ext <= '0';
		wait for clk_ext_period/2;
		clk_ext <= '1';
		wait for clk_ext_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '1';
      wait for 100 ns;
		rst <= '0';
		input_d <= -16000;
		wait for clk_ext_period*500;	
		input_d <= -6000;
		wait for clk_ext_period*500;
		input_d <= 1000;
		wait for clk_ext_period*500;	
		input_d <= 10000;
		wait for clk_ext_period*500;
		input_d <= 15000;
		wait for clk_ext_period*500;
		input_d <= 20000;
		wait for clk_ext_period*500;
		input_d <= 30000;
		wait for clk_ext_period*500;
		input_d <= 32000;
		wait for clk_ext_period;
  end process;
  
  END;