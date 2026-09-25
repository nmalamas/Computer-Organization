--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:24:37 06/14/2024
-- Design Name:   
-- Module Name:   /home/ise/ise_projects/HRY302_PROJECT2_FULLY_FUNCTIONAL/DEC_tb.vhd
-- Project Name:  test_project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DEC_tb IS
END DEC_tb;
 
ARCHITECTURE behavior OF DEC_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         immed_operation : IN  std_logic_vector(1 downto 0);
         writeBackRegister : IN  std_logic_vector(4 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_Out : IN  std_logic_vector(31 downto 0);
         MEM_Out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal immed_operation : std_logic_vector(1 downto 0) := (others => '0');
   signal writeBackRegister : std_logic_vector(4 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_Out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_Out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          immed_operation => immed_operation,
          writeBackRegister => writeBackRegister,
          RF_WrEn => RF_WrEn,
          ALU_Out => ALU_Out,
          MEM_Out => MEM_Out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          RST => RST,
          CLK => CLK,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
      -- hold reset state for 100 ns.
		RST <= '1';
      wait for 100 ns;	

		 Instr <= "10000000000000110000100000110000";
		 immed_operation <= "00";
		 writeBackRegister <= "00011";
		 RF_WrEn <= '1';
		 ALU_Out <= "00000000000000000000000000001100";
		 MEM_Out <= "00000000000000000000000000000000";
		 RF_WrData_sel <= '0';
		 RF_B_sel <= '0';
		 RST <= '0';
       wait for CLK_period;

      wait;
   end process;

END;
