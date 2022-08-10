--[[

    Gachapon Power By @NC Community V.1.4

]]--

Config = {}
Config.volume = 0.5 -- ปรับเสียงตอนกดปุ่มรับของ 0 - 1 สามารถเป็นทศนิยมได้
Config.volumespin = 0.5 -- ปรับเสียงตอนกดปุ่มรับของ 0 - 1 สามารถเป็นทศนิยมได้
Config.limitgacha = 100 -- จำนวนลิมิตการเปิดกาชาปอง
Config.time = 10 -- ปรับระยะเวลาเปิดกาชา หน่วยเป็นวินาที ( ต้องไม่ต่ำกว่า 5 วินาที และ ไม่เกิน 20 วินาที ไม่งั้นเลขของจะไม่ตรง ) **
Config.pressGacha = "Press [~g~E~w~] to open Gachapon" -- อักษรหน้า NPC ที่เปิดกาชา
Config.pressEnter = "Press [E] to enter Gachapon zone" -- อักษรหน้าวงวาปเข้าไปเปิดกาชา
Config.pressExit = "Press [E] to exit Gachapon zone" -- อักษรออกวงวาป
Config.imglocal = "esx_inventoryhud/html/img/items/" -- ปรับที่อยู่ของไฟล์ภาพ
Config.WebHook = ' YOUR WEBHOOK ' --ใส่เว็บฮุก discord

Config.warp = { -- วงวาปจากจุดที่ 1 ไปจุดที่ 2 สามารถใส่ได้หลายจุดและใส่ type ด้วยนะครับว่าเป็นวงเข้าหรือออก (อย่าลืมใส่ , ด้วยนะครับ)
    {go = {x=334.2,y=-1394.18,z=32.51}, to = {x=326.59, y=-1395.05, z=32.51}, type = 'enter'},
    {go = {x=331.18,y=-1395.61,z=32.51}, to = {x=326.59, y=-1395.05, z=32.51}, type = 'exit'},
}

Config.Marker = {
    enter = {
        id = 21,
        scaleX = 1.0,
        scaleY = 1.0,
        scaleZ = 1.0,
        r = 231,
        g = 0,
        b = 255
    },
    exit = {
        id = 0,
        scaleX = 1.0,
        scaleY = 1.0,
        scaleZ = 1.0,
        r = 231,
        g = 0,
        b = 255
    }
}

Config.Npcs = { -- เซ็ตจุดยืนและตัวละคร NPC
    regis = {
        Model = "mp_f_execpa_01",
        Pos = {
            x = 339.0,
            y = -1396.14,
            z = 32.51,
            h = 59.28
        }
    },
    hospital = {
        Model = "mp_f_execpa_01",
        Pos = {
            x = 345.0,
            y = -1396.14,
            z = 32.51,
            h = 59.28
        }
    }
}

Config.vehicles = { -- ของชิ้นไหนที่เป็นรถให้ทำการใส่ชื่อรถด้วยนะครับในส่วนกาชารถถ้าให้ออกยากแนะนำไม่เกิน 0.05% และสามารถปรับได้ต่ำกว่า 0.1 เช่น 0.001 เป็นต้น (ไม่แนะนำให้ใส่เป็นกาชารถสักเท่าไหร่)
    't20',
    'zentorno'
}

Config.AllGacha = { -- เซ็ตกาชา อันแรกเป็นชื่อกาชาปอง และข้างในสุดเป็นไอเทมที่จะสุ่มได้ ** (ไอเทมทั้งหมดต้องรวมกันให้ได้ 100% หรือ น้อยกว่านั้นแต่ถ้าปรับน้อยกว่า 100% จะมีโอกาศไม่ออกอะไรเลยภายในกาชา) **
    water = {
        items = {
            {name = 'gold', label = 'ทอง', count = 1, chance = 30},
            {name = 'water', label = 'น้ำ', count = 1, chance = 50},
            {name = 'bread', label = 'ขนมปัง', count = 1, chance = 20},
        }
    },
    bread = {
        items = {
            {name = 'copper', label = 'เศษทอง', count = 1, chance = 0.5},
            {name = 'comet2', label = 'รถโคเมด', count = 1, chance = 0.1},
        }
    }
}