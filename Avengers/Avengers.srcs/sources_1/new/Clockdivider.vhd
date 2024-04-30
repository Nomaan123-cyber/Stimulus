----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2023 20:00:55
-- Design Name: 
-- Module Name: Clockdivider - Behavioral
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

entity Clockdivider is
 port (
       clock_1: in std_logic;
       clock_2: out std_logic;
       clock_3:    out std_logic;
       clock_4: out std_logic
   );
end Clockdivider;

architecture Behavioral of Clockdivider is
 signal line_2:   std_logic := '0';
   signal line_4:   std_logic := '0';
   signal line_3:    std_logic := '0';
begin

 clock_2 <= line_2;
    clock_4 <= line_4;
    clock_3 <= line_3;
    
FREQ_2:    process(clock_1, line_2)
    variable count_100000:      unsigned (15 downto 0)  := "1100001101010000";  
    variable counter_100000:    unsigned (15 downto 0)  := "0000000000000000";        
    begin
        if (rising_edge(clock_1)) then
            if (counter_100000 = count_100000) then
                line_2 <= not line_2;
                counter_100000 := "0000000000000000";
            end if;
            counter_100000 := counter_100000 + 1;
        end if;
    end process;
    
FREQ_4:    process(clock_1, line_4)
        variable count_12500:   unsigned (12 downto 0)  := "1100001101010";      
        variable counter_12500:       unsigned (12 downto 0)  := "0000000000000";     
    begin
        if (rising_edge(clock_1)) then
            if (counter_12500 = count_12500) then
                line_4 <= not line_4;
                counter_12500 := "0000000000000";
            end if;
            counter_12500 := counter_12500 + 1;
        end if;
    end process;
    
FREQ_3:       process(clock_1, line_3)
        variable count_100000000:   unsigned (25 downto 0)  := "10111110101111000010000000";  
        variable counter_100000000: unsigned (25 downto 0)  := "00000000000000000000000000";        
    begin
        if (rising_edge(clock_1)) then
            if (counter_100000000 = count_100000000) then            
                line_3 <= not line_3;
                counter_100000000 := "00000000000000000000000000";
            end if;
            counter_100000000 := counter_100000000 + 1;
        end if;
    end process;
        
end Behavioral;

