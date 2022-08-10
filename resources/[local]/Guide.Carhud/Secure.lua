Config = {};

--[[

    This encryption system is made to work with Dynamic.
    Copyright ©2021-2022 Dynamic Coding

    @ ATTENTION ( 1 )
     -- > ซื้อ Session ได้ที่ http://dynamicng.com
 
]]--



--[ @ Session ที่ได้จาก Website
Secure = {
    Session  = 'PUT_SESSION_HERE',
    Debug_mode = false, -- @ DEBUG ของทรัพยากร
} Dynamic ={}; 



Dynamic.Directions = { [0] = '', [1] = '', [2] = '', [3] = '', [4] = '', [5] = '', [6] = '', [7] = '', [8] = '' } 

Dynamic.Setting = {
    -- [ @ Seatbelt
    Input = 29, -- @ ปุ่มสำหรับกดรัดเข็มขัด
    EjectSpeed = 45, -- @ ความเร็วเฉลี่ยเวลาชนแล้วกระเด็นออกรถ
    EjectAccel = 100, -- @ อัตราเร่งเฉลี่ยเวลาชนแล้วกระเด็นออกรถ
    -- ] 
    -- [ @ Sound
    Volume = 0.5, -- @ ความดังของเสียงเวลาใส่เข็มขัด
    AddName = "AddBelt", -- @ ชื่อไฟล์เสียงใส่เข็มขัด # นามสกุลไฟล์เป็น ogg เท่านั้น
    RemoveName = "RemoveBelt", -- @ ชื่อไฟลฺ์เสียงถอดเข็มขัด # นามสกุลไฟล์เป็น ogg เท่านั้น
    -- ]
    -- [ @ UI 
        Scale = 1 -- @ ขนาด UI ใหญ่เล็ก ไม่เกี่ยวกับความสั้นยาว
    --]
}




Config.BeltClass = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = false,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = false,
    [14] = false,
    [15] = false,
    [16] = false,
    [17] = true,
    [18] = true,
    [19] = true,
}