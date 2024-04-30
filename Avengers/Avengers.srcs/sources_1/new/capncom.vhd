----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2023 19:43:20
-- Design Name: 
-- Module Name: capncomp - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity capncomp is
 Port (
       clock_3:      in std_logic;
       random_number:  in std_logic_vector(3 downto 0);
       control:        in std_logic;
       count_reached:  out std_logic
   );
end capncomp;

architecture Behavioral of capncomp is


 component four_bit_latch is
       port (
           D:  in std_logic_vector(3 downto 0);
           E:  in std_logic;
           Q:  out std_logic_vector(3 downto 0)
       );
   end component;

   component comparator_fourbit is
       port (
           a:      in std_logic_vector(3 downto 0);
           b:      in std_logic_vector(3 downto 0);
           gtoe:   out std_logic;
           clock:  in std_logic;
           pause:  in std_logic
       );
   end component;
   
   component counter_wrapper is
       port (
           CLK : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
           SCLR : in STD_LOGIC
       );
   end component;
   
   signal latch_to_comparator_input_b:     std_logic_vector(3 downto 0);
   signal count_to_comparator_input_a:     std_logic_vector(3 downto 0); 
begin


   
   
CCOMPARE: four_bit_latch port map(D=>random_number, E=>control, Q=>latch_to_comparator_input_b);
CCOUNTER: counter_wrapper port map(CLK=>clock_3, Q=>count_to_comparator_input_a, SCLR=>control);
COMPARAT: comparator_fourbit port map(a=>count_to_comparator_input_a, b=>latch_to_comparator_input_b, gtoe=>count_reached, clock=>clock_3, pause=>control); 
          

end Behavioral;
