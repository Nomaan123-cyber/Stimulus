----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2023 20:10:06
-- Design Name: 
-- Module Name: Sevensegmentd - Behavioral
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

entity Sevensegmentd is
 Port (clk_4 : in std_logic; 
         one_mils : in integer; 
         ten_mils : in integer; 
         hundred_mils : in integer; 
         one_sec : in integer; 
         f_state : in std_logic_vector(2 downto 0);   
         anode : out std_logic_vector(7 downto 0); 
         cathode : out std_logic_vector(7 downto 0) 
         );
end Sevensegmentd;

architecture Behavioral of Sevensegmentd is
begin
process(clk_4)   
        variable seg_sel: unsigned (1 downto 0) := "00";
begin
    if rising_edge(clk_4) then
        if f_state = "000" then 
                case (seg_sel) is
                    when "00"  => 
                        anode <= "11110111";
                        cathode <= "11111111";
                    when "01" =>    
                        anode <= "11111101";
                        cathode <= "10010001";
                    when "10" =>    
                        anode <= "11111110";
                        cathode <= "11110011";
                    when "11" =>    
                        anode <= "11111110";
                        cathode <= "11111111";
                    when others =>  
                        anode <= "11110000";
                        cathode <= "11111110";
                end case;
                seg_sel := seg_sel + 1;
        elsif f_state = "001" then 
                anode <= "11110000"; 
                cathode <= "11111111"; 
        elsif ((f_state = "010") or (f_state = "100")) then 
            case (seg_sel) is
                when "00" =>
                    anode <= "11110111"; 
                    case (one_sec) is
                        when 0 =>
                            cathode <= "00000011";
                        when 1 =>
                            cathode <= "10011111"; 
                        when others =>
                            cathode <= "11111110"; 
                        end case;
                when "01" =>
                    anode <= "11111011"; 
                    case (hundred_mils) is
                        when 0 =>
                            cathode <= "00000011";  
                        when 1 =>
                            cathode <= "10011111"; 
                        when 2 =>
                            cathode <= "00100101"; 
                        when 3 =>
                            cathode <= "00001101"; 
                        when 4 =>
                            cathode <= "10011001"; 
                        when 5 =>
                            cathode <= "01001001"; 
                        when 6 =>
                            cathode <= "11000001";  
                        when 7 =>
                             cathode <= "00011111";  
                        when 8 =>
                             cathode <= "00000001";  
                        when 9 =>
                             cathode <= "00011001";  
                        when others =>
                              cathode <= "11111110";  
                        end case;
                when "10" =>
                    anode <= "11111101";
                        case (ten_mils) is
                            when 0 =>
                                cathode <= "00000011";
                            when 1 =>
                                cathode <= "10011111";
                            when 2 =>
                                cathode <= "00100101";
                            when 3 =>
                                cathode <= "00001101";
                            when 4 =>
                                 cathode <= "10011001";
                            when 5 =>
                                 cathode <= "01001001";
                            when 6 =>
                                  cathode <= "11000001";
                            when 7 =>
                                  cathode <= "00011111";
                            when 8 =>
                                  cathode <= "00000001";
                            when 9 =>
                                  cathode <= "00011001";
                            when others =>
                                   cathode <= "11111110";
                            end case;
                when "11" =>
                    anode <= "11111110";
                    case (one_mils) is
                        when 0 =>
                            cathode <= "00000011";
                        when 1 =>
                             cathode <= "10011111";
                        when 2 =>
                             cathode <= "00100101";
                        when 3 =>
                              cathode <= "00001101";
                        when 4 =>
                              cathode <= "10011001";
                        when 5 =>
                              cathode <= "01001001";
                        when 6 =>
                              cathode <= "11000001";
                        when 7 =>
                              cathode <= "00011111";
                        when 8 =>
                              cathode <= "00000001";
                        when 9 =>
                              cathode <= "00011001";
                        when others =>
                              cathode <= "11111110";
                         end case;             
                when others =>
                    anode <= "11110000";
                    cathode <= "11111110";
            end case;
            seg_sel := seg_sel + 1; 
        elsif f_state = "011" then 
                    anode <=  "11110000"; 
                    cathode <= "00011001"; 
       end if;
    end if;
    
end process;
end Behavioral;