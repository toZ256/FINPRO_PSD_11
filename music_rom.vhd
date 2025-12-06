library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.music_pkg.ALL; 

entity music_rom is
    Port (
        addr : in  integer range 0 to 31; 
        data : out std_logic_vector(15 downto 0) 
    );
end music_rom;

architecture Behavioral of music_rom is
    -- ROM 32 baris
    type rom_type is array (0 to 31) of std_logic_vector(15 downto 0);
    
    -- Lagu: Twinkle Twinkle (8 baris)
    constant ROM_CONTENT : rom_type := (
        -- Baris 0: Do
        (OP_PLAY & std_logic_vector(to_unsigned(NOTE_C4_HZ, 14))), 
        -- Baris 1: Wait
        (OP_WAIT & std_logic_vector(to_unsigned(WAIT_HALF_SEC, 14))),
        
        -- Baris 2: Do
        (OP_PLAY & std_logic_vector(to_unsigned(NOTE_C4_HZ, 14))), 
        -- Baris 3: Wait
        (OP_WAIT & std_logic_vector(to_unsigned(WAIT_HALF_SEC, 14))),
        
        -- Baris 4: Sol
        (OP_PLAY & std_logic_vector(to_unsigned(NOTE_G4_HZ, 14))), 
        -- Baris 5: Wait
        (OP_WAIT & std_logic_vector(to_unsigned(WAIT_HALF_SEC, 14))),
        
        -- Baris 6: Sol
        (OP_PLAY & std_logic_vector(to_unsigned(NOTE_G4_HZ, 14))), 
        -- Baris 7: Wait
        (OP_WAIT & std_logic_vector(to_unsigned(WAIT_HALF_SEC, 14))),
        
        -- Baris 8: La
        (OP_PLAY & std_logic_vector(to_unsigned(NOTE_A4_HZ, 14))), 
        -- Baris 9: Wait
        (OP_WAIT & std_logic_vector(to_unsigned(WAIT_HALF_SEC, 14))),
        
        -- Baris 10: La
        (OP_PLAY & std_logic_vector(to_unsigned(NOTE_A4_HZ, 14))), 
        -- Baris 11: Wait
        (OP_WAIT & std_logic_vector(to_unsigned(WAIT_HALF_SEC, 14))),

        -- Baris 12: Sol (Note Panjang)
        (OP_PLAY & std_logic_vector(to_unsigned(NOTE_G4_HZ, 14))),
        -- Baris 13: Wait Panjang (1000ms)
        (OP_WAIT & std_logic_vector(to_unsigned(1000, 14))),
        
        -- Baris 14: Loop kembali ke 0
        (OP_LOOP & std_logic_vector(to_unsigned(0, 14))),
        
        others => (OP_STOP & std_logic_vector(to_unsigned(0, 14)))
    );
begin
    data <= ROM_CONTENT(addr);
end Behavioral;