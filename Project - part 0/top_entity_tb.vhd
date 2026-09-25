--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   07:54:43 03/30/2024
-- Design Name:   
-- Module Name:   /home/ise/HRY302_LAB0/top_entity_tb.vhd
-- Project Name:  HRY302_LAB0
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_entity
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY top_entity_tb IS

END top_entity_tb;
 
ARCHITECTURE behavior OF top_entity_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT top_entity
    PORT(
			--Inputs
         CLK       : IN  std_logic;
         RST       : IN  std_logic;
         AddrWrite : IN  std_logic_vector(4 downto 0);
         AddrRead  : IN  std_logic_vector(4 downto 0);
         w         : IN  std_logic;
         r         : IN  std_logic;
         NumberIN  : IN  std_logic_vector(15 downto 0);
         
			--Outputs
			Valid     : OUT  std_logic;
         NumberOUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal AddrWrite : std_logic_vector(4 downto 0) := (others => '0');
   signal AddrRead : std_logic_vector(4 downto 0) := (others => '0');
   signal w : std_logic := '0';
   signal r : std_logic := '0';
   signal NumberIN : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Valid : std_logic;
   signal NumberOUT : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_entity PORT MAP (
          CLK => CLK,
          RST => RST,
          AddrWrite => AddrWrite,
          AddrRead => AddrRead,
          w => w,
          r => r,
          NumberIN => NumberIN,
          Valid => Valid,
          NumberOUT => NumberOUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		RST <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		RST <= '0';
      wait for CLK_period*2;

      --Set the current state to Idle--
		--curr_state = "I"
		w <= '0';
		r <= '0';
		wait for CLK_period*2;
		
						--Write--
		--number 5(0000 0000 0000 0101)
		--on address 3(00011)
		w <='1';
		r <='0';
		
		NumberIN <= "0000000000000101";
		AddrWrite <= "00011";
		wait for CLK_period*2;
		
						--Write-- 
		--number 20(0000 0000 0001 0100)
		--on address 8(01000)
		w <='1';
		r <='0';
		NumberIN <= "0000000000010100";
		AddrWrite <= "01000";
		wait for CLK_period*2;
		
						--Read--
		--number on address 3(00011)
		w <='0';
		r <='1';
		AddrRead <= "00011";
		wait for CLK_period*2;
		
						--Read--
		--number on address 8(01000)
		w <='0';
		r <='1';
		AddrRead <= "01000";
		wait for CLK_period*2;
		
		--Set the current state to Write and Read 
		--Write: number 10(0000 0000 0000 1010) on address 16(10000)
		w <='1';
		r <='1';
		AddrRead <= "01000";
		
		AddrWrite <="01000";
		NumberIN <="0000000000001010";
		wait for CLK_period*2;
      wait;
   end process;

END;
