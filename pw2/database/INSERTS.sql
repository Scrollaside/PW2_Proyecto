USE pw2;

-- TRUNCATE TABLE usuario; --

INSERT INTO usuario (nombre_usuario, nickname_usuario, foto_usuario, desc_usuario, email_usuario, contrasenia_usuario) VALUES
('User Test One', 'UserTest01', 0, 'User Description', 'email@mail.com', 'Userpass1!');

INSERT INTO usuario (foto_usuario, nombre_usuario, nickname_usuario, desc_usuario, email_usuario, contrasenia_usuario) VALUES 
(0, 'Danny B.', 'moshiOnO', 'Me gusta comer xD', 'moshiuwu@uanl.edu.mx', 'mipapáesfox#20'),
(0, 'Prueba Es mi Nombre', 'prueba', 'soy una prueba', NULL, 'prueba'),
(0, 'Sei', 'seis', 'soy el usuario seis', NULL, 'seis'),
(0, NULL, 'pro2', NULL, NULL, NULL),
(0, 'Sonic is my Name', 'TheBlueH', 'I like CHili dogs and minecraft :3', 'sonic@gmail.com', 'Contraseña#20');


-- TRUNCATE TABLE publicacion; --

INSERT INTO publicacion (id_post, id_autor, titulo_post, desc_post, fecha_post, foto_post) VALUES 
(1, 1, 'March 7th', 'OMG, just starting playing HSR and i LOVE this living protogem', '2017-05-17 20:47:09', 0),
(5, 1, 'Yanfo', 'Vete alaberga, me llevo como 30 min acabar esta wea conchetumadre, pero como la amo uwu', '2024-05-18 14:18:18', 0),
(6, 6, 'Uraraka sketchie', 'Un skecth rapidito que hice', '2024-05-17 15:32:59', 0),
(8, 1, 'Hu TAOOOOOOOO', 'Como quiero a la Hu tao', '2024-05-18 14:27:16', 0),
(9, 6, 'Makoto Yuki', 'March 5th ....', '2024-05-19 14:37:17', 0);


-- TRUNCATE TABLE categoria --

INSERT INTO categoria (id_cat, title_cat) VALUES
(1, 'anime'),
(2, '2d'),
(3, 'oc'),
(4, 'illustration'),
(5, 'nintendo'),
(6, 'marvel'),
(7, 'dc'),
(8, 'youtube'),
(9, 'drawing'),
(10, 'sketch'),
(11, 'digital'),
(12, 'Cats');


-- TRUNCATE TABLE comentario --

INSERT INTO comentario (id_comm, id_usuario, desc_comm, fecha_comm) VALUES
(1, 1, 'Holaaaaa', '2024-05-15 16:43:25'),
(6, 1, 'asdsd', NULL),
(7, 1, 'ala', NULL),
(8, 1, 'este comentario tendrá una cantidad excesiva de texto xD', NULL),
(9, 6, 'Ta bien bonita tu yanfooooo', NULL),
(10, 6, 'Mucho texto, ya kys', NULL),
(11, 1, 'Holi, primer comentario', NULL);


-- TRUNCATE TABLE follow --

INSERT INTO follow (id_follow, id_usuario, id_ufollowed, fecha_follow) VALUES
(1, 1, 1, '2024-05-12 14:02:23'),
(2, 2, 1, '2024-05-12 14:04:06'),
(9, 6, 1, '2024-05-19 14:29:30');


-- TRUNCATE TABLE likes --

INSERT INTO likes (id_like, id_usuario, id_post, fecha_like) VALUES
(6, 1, 5, '2024-05-18 12:16:20'),
(7, 1, 1, '2024-05-18 12:16:25'),
(9, 1, 8, '2024-05-19 12:57:28'),
(10, 6, 1, '2024-05-19 14:29:29');

-- TRUNCATE TABLE post_cat --

INSERT INTO post_cat (id_pcat, id_cat, id_post) VALUES
(6, 1, 6),
(7, 8, 6),
(8, 9, 6),
(17, 1, 8),
(18, 2, 8),
(19, 4, 8),
(22, 1, 1),
(23, 8, 1),
(24, 1, 5),
(25, 2, 5),
(26, 4, 5),
(27, 1, 9),
(28, 4, 9),
(29, 9, 9);


-- TRUNCATE TABLE post_comm --

INSERT INTO post_comm (id_pcomm, id_comm, id_post) VALUES
(1, 1, 1),
(2, 6, 1),
(3, 7, 1),
(4, 8, 1),
(5, 9, 5),
(6, 10, 1),
(7, 11, 6);


-- TRUNCATE TABLE usu_cat --

INSERT INTO usu_cat (id_usucat, id_usuario, id_cat) VALUES
(1, 1, 3);


-- DEFAULT PICTURES --

UPDATE usuario
SET foto_usuario = UNHEX('FFD8FFE000104A46494600010100025802580000FFDB008400080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC200110803D403D403012200021101031101FFC4002F000100020301010000000000000000000000060703040502010101010100000000000000000000000000000102FFDA000C03010002100310000000B706F200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001878A4810AD02C4567E52CE56DB8B3D453B274800000000000000000000000000000000000000000000000000000000000000000000000000000000007220C4D22B1F27AF258000001BB2785A5B77669D96ACD58F20000000000000000000000000000000000000000000000000000000000000000000000000000354CF08E472902C000000000000DEB06B0F52DC88A4AD40000000000000000000000000000000000000000000000000000000000000000000000006A1E2B369A05800000000000000098C392DCC86CC940000000000000000000000000000000000000000000000000000000000000000000000C758752308160000000000000000002C2AF724B7139FD0500000000000000000000000000000000000000000000000000000000000000000001C1EDD52690B9000000000000000000000EB59F4D4F659485000000000000000000000000000000000000000000000000000000000000000007922707DAD540B0000000000000000000001B5AA8B8B245256D000000000000000000000000000000000000000000000000000000000000000008E48EB63842E4000000000000000000000003A16B533684BD60A0000000000000000000000000000000000000000000000000000000000000018AA0B1EB640B00000000000000000000000013087F5A5B40280000000000000000000000000000000000000000000000000000000000000043219228EA058000000000000000000000000F5E45C9EB9DD19A000000000000000000000000000000000000000000000000000000000000000AC391D0E7A0580000000000000000000000000593DD8E48F3A0A00000000000000000000000000000000000000000000000000000000000002A7D1DFD040B000000000000000000000000016C192C6E499A140000000000000000000000000000000000000000000000000000000000000559CCECF1902C00000000000000000000000002C690717B5340000000000000000000000000000000000000000000000000000000000000015DC765F1040B000000000000000000000000022D5E8E3C8D000000000000000000000000000000000000000000000000000000000000000462016955A81600000000000000000000000036F53BEB63894000000000000000000000000000000000000000000000000000000000000003E53F70D7291F1600000000000000000000000026F08B4E5E98500000000000000000000000000000000000000000000000000000000000000046A4B88A799B0DC8000000000000000000000006F5B10D994D00000000000000000000000000000000000000000000000000000000000000000041E236ED4E98858000000000000000000000C98E5D2CBF6450000000000000000000000000000000000000000000000000000000000000000004465DF0A69D9E332140000000000000000003E9B36B727B934000000000000000000000000000000000000000000000000000000000000000000001AD57DB3A454CDDD2B90000000000000000004DF1CCE505000000000000000000000000000000000000000000000000000000000000000000000035ABCB33E14D2770B4C02C0000000000001DD978D3CEC6F280000000000000000000000000000000000000000000000000000000000000000000000000030E61108B5B02995A7C3484243CE4E7BDF8001F4F8D9DFAE3A57D996BD904FB31C7EC0A000000000000000000000000000000000000000000000000000000000000000000000000000000000031651ADF36860CBE800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004001400000000000000000000000000000000000000000000000000000000000000000000000000000000073F864B15CF252D3E756627DA70D12AC31B5487E47C922C9192CBB6A0E8B13A1558B93D537D32D1417B6BDF63C8000000000000000000000000000000000000000000000000000000000000000000000007C8F921E7C0F8A9318EE8102D0400000000000005F7DD8FA2C4EFD39B05BC844AD770000000000000000000000000000000000000000000000000000000000000000038E75E3911E5A7439E2050000000000000000000003D7944A26552FB5B8D0998AE5000000000000000000000000000000000000000000000000000000000000C3CBAF8EE46040B0000000000000000000000000001B9A696C8EF5332827CC7914000000000000000000000000000000000000000000000000000000633DC3B971F4FBF0A0400000000000000000000000000000003A362D539A5B81C3EE28000000000000000000000000000000000000000000000000000D63ED6F8F9A8160000000000000000000000000000000000007A9F57E96E645256A000000000000000000000000000000000000000000000000319E2B2C9C940B00000000000000000000000000000000000000013D817D96E547A42A00000000000000000000000000000000000000000000002BBEA42502C000000000000000000000000000000000000000000F76755DB72DB6D6D9500000000000000000000000000000000000000000001C7E95566A7C102C00000000000000000000000000000000000000000003B964D353A96581400000000000000000000000000000000000000001C823316FBF102C00000000000000000000000000000000000000000000064C62D8DEADAC99A00000000000000000000000000000000000000003E55F2EAF00B90000000000000000000000000000000000000000000000005915BF465B55F3EA80000000000000000000000000000000000000F9F63E4279E58080000000000000000000000000000000000000000000000000B61C8EACB4E50000000000000000000000000000000000000158CF6AA40B0000000000000000000000000000000000000000000000000001665672296C40A0000000000000000000000000000000000010788EDEA2058000000000000000000000000000000000000000000000000000F5E45BF9E2F289A00000000000000000000000000000000001C9EB42C868B9000000000000000000000000000000000000000000000000000000EED934E5BF2E40A000000000000000000000000000000000AC6CBA793C8B000000000000000000000000000000000000000000000000000000165D69339666140000000000000000000000000000000039357CF6048160000000000000000000000000000000000000000000000000000003BBC2DA96DC0A000000000000000000000000000000001068977F80816000000000000000000000000000000000000000000000000000000017066E5F5268000000000000000000000000000000002ADE5EDEA5C80000000000000000000000000000000000000000000000000000000058FDF8C49E6800000000000000000000000000000007DF829EC5EBCB21400000000000000000000000000000000000000000000000000000004E65B0E98CD00000000000000000000000000000000F814DFC190A0000000000000000000000000000000000000000000000000000000267332680000000000000000FFC4004B100001030103060B0504090204070000000102030405000611122131415160131422325061718191B1C1234252A1D1154062722430334353638283E13544167392933490A2C0D2F0F1FFDA0008010100013F00FF00D809C8951E2232A43EDB29DAB5016937C692C121B5B9215FCB466F13859FBF8B3888F01206D71CC7E42CE5F5AB2F99C5DB1F85BC7CCD957AEB4A3FF8CC3B1B48F4B0BD35A1FEF95DE84FD2C8BDF5946990DAFF003342CCDF99E93ED63477075629B47BF5117809111E6BAD04287A5A25E0A54DC03331B0A3EEB9C83F3B6AC756F768B54AF5D3606284ACC9787B8D1CC3B55A2D3EF854E5E2965498AD9D4DF3BFEA3E9671C5BAB2B716A5ACFBCA389FD4E9B42ABD429E471594E213F0138A7C0E6B53EFC83822A11F0FE6B3EA93E96873E2D41AE122BE8753AF24E71DA348DEBABDE38549050B570B23532839C769D56AA5E29F55252E39C1B1A996F30EFD67F5EC487A33C1D61D5B6E0D0A41C0DA937D540A59A9A311A3876C67EF1F4B30FB52594BCC38971B568524E20EF3BAF36C34A75D71286D031529470005AB77C5C7CAA3D34A9A6B4178E652BB360F9D8924924924E724FDCA9B56994A7B848AEE00F390ACE95768F5B516F0C4AC20213ECA481CA65474F5A4EB1BCB50A8C6A64554892BC948CC00D2A3B00B566BB2AB2F72CF071D2790C8398759DA7EEA85A9B5A568514AD2710A49C0836BBD7AD328A22541410F9CC877405F51D87CF78EAB558F48885F7CE24E64206959D83EB6A9D4E4D56599125589D0940E6A06C1F78BB57A0A4A20541CC4735A794746C0AFAEF0D4AA2C52E12E4C85724664A46951D405AA752915598A9320E7399291A10360FBD5D5BC794514D9ABCFA18755AFF09F43BBEFBED46616FBCB086D03294A3A85AB95876B138BA714B08CCD36750DA7ACFDF2EB57FED0604392BFD29B19947F789DBDA35EEF5EEAE71C9060475FE8ED1E591EFAFE83CFEFB1DF762C843ECACA1C6CE5254351B51AAADD5E9E8908C12B1C9711F0ABE9BB97A6B3F6640E09956129F04230D294EB57DFEEFD5D548A9256A278BB9C9753D5B7BAC95052429241491882358DDA79D430CADE75592DA1254A51D405AAB5172A9517652F101470427E148D03A02E655B8CC434F7958BAC0C5BC75A36771F91DDABED54E0A3B74E695CA7796EE1F08D03BCF9740D3A6B94E9ECCB6F9CDAB12368D63C2CC3EDC961B7DA56536E242927A8EEC38E219696EB87250849528EC02D529ABA8D41F96BD2E2B10360D43C3A0AE45478686EC05AB96C9CB6F1F84E91DC7CF762F9CFE2B481192AC17255927F28CE7D0741D1279A6D5E3C827040564B9D69398DBB0E3BAF7BA6F1BAEB8DA4E288E3821DBA4FCFCBA12EDCEE3F428EE28E2E20704BED4FF8C375A4BE98B15D90BE6B682B3DC2CE38A79D5BAB38AD6A2A27ACE7E84B892F07654351CCA01D48EB198FA6EB5EF93C5EEFBA807053CA4B63B349F90E85BB5278ADE088B2704AD5C1ABB159BCF0DD6BF8FE7851C1F89C23E43D7A15B70B4E25C4E942828771C6CDB81D690E0D0B4850EF18EEADF57784AFE46399B6529F1C4FAF43505EE1E810578E278100F766F4DD5BCEBE12F24D3F0AC27C00E86BA0BCBBB6C0F856B4FCFF00CEEAD755955E9E7F9EAE86B92AC68246C7D7E9BAB5AFF5C9FF00F3D7E7D0D723FD0DCFF9EAF21BAB5C1857A78FE7ABCFA1AE48C282A3B5F5790DD5BC49C9BC53C7F349F2E86B989C9BBC93F13AB3BAB7AD1917925FE229578A47435D34645DB8BF8B295E2A3BAB7D5BC8AFE57C6CA0F98E86A0B7C1502023F9293E39F756FE3584984F7C48520F71C7D7A1702730D2735A3B7C0C565A1EE2129F01BAB7E58CBA432F019DA7803D8461E83A1694C719AB43670C72DE483D98DB5EEADE38DC6AEFCC401894A32C76A73F42DCE8FC3DE06D6466650A5F7E81E7BACB48710A42B9AA041EC3692C2A2CA7A3AB9CD2CA0F71C3A12E245C9625CB239CA0DA4F50CE7CC6EBDF187C5ABAA740E4484873BF41F2E84BBD0F88D0A2B4460B29CB576AB3EEBDF585C629289291CA8EBC4FE5398FCF0E83A3C2350AB468D87254B057F946736EEC375E43089519D8EE0C50EA4A15D86D2A32E1CB76338396D28A4F77415C6A7E097EA0B1A7D937E6A3E43766FBD378390D545B1C973D9B9F98683DE3CBA05865C90FB6CB43171C504A4759B53E1A29F0198ADF35A4818ED3ACF8EECD421375180F44779AE270C761D47B8DA4C772249763BC9C971B514A875F405C9A5708F2EA6EA7928C50CE3AD5ACF768EFDDBBE747E15B153613CB40C9780D69D4AEEF2FBFD3A03B539ED45679CB39D5A92359368B19A8715A8CCA725B6D39291BB6A4A5692950052A181074116BC544551E6F201315D24B4AD9F84F6797DF402A504804939801AED766882930F8479238DBC315FE11A93F5EBDDD9F058A943722C84E2858D3AD27511D76AAD2DFA4CD5477C6234A160665A768FBE5D4BBA59C8A94C47B439D96D439BF88F5ECDDFAA52A3D5A1961F4E7D2858D283B45AA94A93499458909CC73A1639AB1B47DEAED5D638A27545BFC4D30AF9150F4DE19D02354632A3CA6C2D07C527683A8DAB776E552145C4E2F45C733A0737A9435797DDD861D94F25961B538E28E012918936A05D46E0644A9B92EC9D294694B7F53BC640524A5401046041D76AC5CC664153D4D2965CD25A5730F66CF2B4B85260BC5994CADA58D4A1A7B0EBFBA526EB4EA964B8E278B473EFAC675760B532910E92CE4466F051E738ACEA5769F4DE693123CC64B325943AD9F75631FFF002D51B8EDAC95D3DFE0CFF09DCE3B8E9B4EA35429C4F198AB4A7E303293E23F5EDB6E3CE0434852D674252313681736A5288548C98AD9F8F3ABC07ADA997669D4D295A5AE19E1FBD77391D8340DEAD586AB4BBBD4A9A49761A12B3EFB7C83F2B49B88CAB13126AD1F85D4E50F11859FB99566B12D865E1F81CC0F81C2CF50AAAC7ED29F2075846579596C3ADF3DA713F99045B11B6D88DA2D88DA2D88DA3C6C01573413D831B354F9AF9F650E42FF002B67E9662EB565FD108B636B8A09B47B8B2D781932D96C6C402A3E82D16E652D8C0BDC2C857E35603C05A3448F111911986DA4EC4240DF139F4E7EDB2A330BE7B0D2BB500D8D3A0AB4C38E7FB49FA5853200D10A37FDA4FD2C985113CD8AC0EC693F4B25B4239A84A7B1205B13B4FF00E5B0FD46146FDBCC61BEA53831F0B3B7B28CCE3FA5170FF2D04D9DBF34F4FECE3495F6E09F5B397F4FEEE9DFF5BBF41655FB9C7990E327B4A8D957DEAA742230FED9FAD8DF4AC1F7A38FED7F9B7FC6758F8D8FFB22C2FAD5C69E2E7FB5FE6C9BF3521CE622ABFA48F5B22FE481FB480D1FCAE1166EFE473FB580EA7F2B80FD2CD5F4A4B9CFE1DAFCCDE3E5662F05264666E7B38EC59C93F3B36E36E8C5B5A1636A540F96F4CBAE5320E21F98D850F7127295E02D2AFD46462224471D3A94E2B24786736937CAACFE21B534C03FC34627C4E3691529D2C9E1E5BEE63A94B38787EBDB716D2B29B5A9076A4E1E568F792AF170C89AE2923DD73058F9DA2DFA928C04A88DB83E26D4527C338B44BE149918071C5C751D4EA73788B312199280B61D43A9DA8503E5BC53AB74EA76224CA405FF000D3CA5780B4EBF4A38A6045091F1BC713E02D36B5519E4F1896E2927DC49C94F80FBBB4F3AC2F2D9716DAFE242883F2B42BE1548B825D5A24A06A7067F116837CA9B2704C8CB8AB3F1E74F88B34EB6FB61C69C4B883A148388DDC51094952880919C92730B546F853A162860994E8D4D9C123B55F4B542F454EA18A386E01A3EE339BC4E936D38F5E9FBE449B2A0B9C2457DC695F80E63DA341B53AFC388C115060389FE23598F78D07BAD02A90AA48CA89210E6D4E850ED1A776090904920019C93AAD54BE30A1E5371071A7866C41C103BF5F75AA35A9F5451E32F92DE399B4E640EED7DFD02DB8B69C4B8DAD485A742927023BED4BBE92A3E0DCF4F196FE319963D0DA9F5487536B2E23C95E1A51A149ED1BAB57BC906938A14AE1A47F09074769D56AAD7E7559443CE6433A996F327BF6F7F42B4F38C3A9759714DB89D0A49C08B526FAA9392CD4D1943470E819C768D7DD68F21994CA5E61D4B8DAB4292711BA32A5C7851D4FC9752DB63DE5790DB6ACDF091302988194C307315FBEAFA0B1249C49C49E88A7D525D2DFE162BA518F39273A55DA2D46BD112A992CBB83128E6C851E4ABF29F4DCFADDE48B4805A1EDA56A681E6FE63ABB34DAA1529754905E94E959F752332523601D1944BDEF44C98F502A798D01CD2B47D47CECC486A5309798712E36B18A5493883B9648009240033926D5EBDF86545A5AB3E8548FF00E3F5F0B29454A2A5124938924E24F47526B52E8EFE5B0ACA6D4796D28F255F43D76A55622D5E3F091D582D3CF6D5CE4FF8EBDC97DF6A330B79F712DB6818A94AD02D5FBCEF5514A8F1B29A878E8D0A73B7ABABA462CA7E1484BF1DC536EA74287FF738B502F1B3574065DC1A9806746A5F5A7E9B8F326C7A7C55C892E04369D7AC9D8369B572BD22B2FF002B16E324FB3681F99DA7A4D0B536B4AD0A29524E2140E041B5DCBCE99F93126A8265684AF4077E87CF7167CE8F4D88B932579284EAD6A3B075DAB159915895C23A725A4FECDA073247A9EBE950482083811AC5AECDE7E3791067AFDBE86DD3EFF51EBF3DC399318811572642F21B40CE759EA1D76ACD65FACCBE15CC52D27336D639923EBD7D2E331C45AEC5E5E3A13066AFF490306DC3FBC1B0F5F9EE0BEFB51985BCF2C21B40CA528E802D5EAE3B59978E74466CFB26FD4F59E9904A5414924281C4107022D766F08AA33C5A4A8098D8D3FC41B7B76F4F9200C49C06D36BD1780D4DFE2B195FA1B6748FDE2B6F66CF1E9B65E723BE879959438838A54351B506B4DD66165E64C846675BD8768EA3D3D7BEBD90154B8ABE511EDD60E81F0FD7A769B517E973512983CA4E6524E8527583683399A8C36E530AC50B1A3583AC1EBE9CBC55A4D2207208329DC434366D51ECB294A5AD4B5A8A94A38924E727A7AECD6CD266F06F28F1478E0B1F09D4AFAD8104020820E823A6A5496A1C57243EAC969B4E528DAA95176AB3DC94EE6CA38253A929D43702E756B876BECD90BF68D8C5927DE4ECEEF2E9ABE359E3527ECE615EC59562E11EF2F67779EE0B0FB919F6DF65452E36A0A491A8DA91526EAD4E6E537802732D3F0A8691D3178AAC2934C52D047187390D0EBD67BAC492492492739275EE15D6ABFD99520DBAAC233E42578FBA752BA5C900124E006926D786AA6AD545B893EC1BE4343AB6F7E9DC4BAB56FB46981A7558C88F82158E929D47D3BBA5AF8557895338AB6AC1E938A736A46BF1D1B8B43A9AA93556A463EC8F21D1B5274F869EEB2541490A490411882358E942425254A3800312760B56EA46AB557A4E3ECF1C96C6C48D1F5EFDC6B9D53E394B315C562EC6E48C75A357868E94BDF51E25482C21583B24E40EA4FBC7D3BF71E8151FB2EAECBE4E0D1390E7E53F4D3DD6ECCFD2779EA3F68D69D2838B4CFB26FBB49EF38EE45D6A8F1FA2B61671758F64BEED07C3A4ABB3FECDA3C8900E0BC9C86FF31CC3EBDDB9373A7F15AC71751C1B929C8FEA19C7A8EFE92BF33B2E4C7809399B1C22FB4E8F979EE4B6E2D9750EB6705A141493D62D0A5266C1625239AEA02BB36F481200249C00CE4DAA930D42A92651D0E2C94FE5D03E5B957226F0D4C76228F2985E29FCAAFF0038F485E499C4A832560E0B5A7834F6AB37963B977466715AFB4827043E92D1EDD23E63A42FDCBCF121A4ED7543E43D772D9754C3CDBC8382DB5058ED071B30F26430DBC838A5C4858EF18F47DE895C6AF0CA20E296C8693FD23EB8EE65D293C66EF3009C54C92D1EED1F23D1CEBA19656EAB4212547B863671C53CEADD51C54B5151ED271DCCB87273CC8A4FC2E01F23E9D1D799FE2F77A6281C0AD21B1FD470FAEE6DD07F81BC2CA71C03A9537F2C47CC7475F97F22951D9C7F68F627B123FCEE6D31FE2D548AFE38643A93DD8DB5F46DFC7719B0D9C79ADA944769C3D373738CE348B44778786C3DF1B695788E8DBE4EF0978569D4DB684FCB1F5DCEBB8EF0D77A0A8E90D64F8123D3A36F239C25E29C763993E000DCEB9CE65DDD687C0E2D3F3C7D7A3069B5557C255E6AF6BEBF33B9D71978D1DF47C2F9F9A47460D23B6D295952DE56D7147E6773AE1ABF439A9D8EA4FF00E9E8CD1670E2EACFE23E7B9D708FB39E3F120FC8F462B9A7B2CAE79ED3B9D70BFDFF00F47AFDDFFFC400171101000300000000000000000000000000111090B0FFDA0008010201013F00BFD20CC17FFFC4001E11000202020301010000000000000000000111405000302060708090FFDA0008010301013F00FDFD78F1DCBD0ED5F7A7D3476B308561F9D0DF1842F87952DCAC56C568B17258BDC1E3C7C5E3C764F73AE709D538C29DC87D89DE99C279A01D6CD10BF128F908906F8F918BE17C367FFFD9')
WHERE foto_usuario = 0;

UPDATE publicacion
SET foto_post = UNHEX('524946464A09000057454250565038203E0900001079009D012A5802A3013E2914884321A12112A93464180284B4B77A9FB27A38E763FADFF56FDF7F60C4FD87CBF5FF4DFD55F0BFF5EBCD7D6797279AA7E5BDA5F613AF6FD96FD413CBFF1F805FEA7471DF5B77CF75F9CEF61CF42B0E2AD61090DB13EF9D27DF3A4FBE749F7CE93EF9D27DF3A4FBE749F7CE93EF9D27DF3A4FBE7322FD8D2823D9CAD05BA6CEE5B2185BF5D8D75FA6CEE5B2185BF5D8D75FA6CEE5B2185BF5B90C895C0FDEAF5FB9D5716407E8D75389F02917CEA4103B3964CEE2EA40A1BF794A2DF67137DAD01F72F13E0522F9D48207672C99DC5D481437EF2945BECE26FB5A03EE5E27C0A45F3A9040ECE5933B8BA90286EFE5936A7D1139A16858E09A2121B627DF3A4FBE749F7CE93AECA5FF0621B5CF44756B08486D89F7CE93EF9D27D61BF4FF1E6F41E288EAD61090DB13EF9D27DF3A4FAC37E9FE3CDE83C511D5AC2121B627DE7E733A190144C531422C2EDA0407CFDAAA235232255A9A9314700FDF3A4FBE749D2A4091544E08053C75D96DEC56C4EBB297FC1886D73D11D5AC2121B627D5441C4A29B28B3295BB93EB0DFA7F8F37A0F144756B08486D89F52C09011F0F479397C04DD89F586FD3FC79BD078A23AB5842436C4FBCE569D94C1267DA3DBCF0494B11D35103E0670BC73EF57F1367B0940F6E40760CF37F8AC4173FB48635842396BB6A94816627165570EAD4988D8F9327A598329313EB481BE551D211E1D4B0407423A61B627DF3A4FBE5D56BD940E7A598329313B20179B9B66CE25AA746716507F5C92690DB13EF9D275D94BFE0C436B9E88EAC2007DDC31810281ED40AB8209E163449F7CE93EF9CBFD4A23AB115A4C0BA42005684FAA7F060CA0A01460366EE9C665198A56BA825005B9E2070089FCE022272FF5288EAC4569302E62813EB546B891B627DF2D0FD306BCE20FBC159F3A9816ACABD69652F5EC9A42C5CE94CA0069B2749B806F95474849690DB13EF44DE35E66E5E517811F1BB5EDF90830E92816AF2B007AECA5FF0621B5CF3DF02B427D50E0F9D27DF3A4FA9D5CD987FD38FE5907F58424D21D61ADEEDD0C0B72255A9A93142300A52E8DD9F5F3A4FBE749F7CE93EF9CB4160769F26D6E3D2E8A006C3268106DB5679AA0F3BF74FDCE93EF9D27DF3A4FBE749F54459D9833E9143F2AE5FF444E683910F1144A4D4B257AA7B55AC2121B627DF3A4FBE72D03E2E92CDA52572F4613C73079A42CE3FCA7707ED55F98EA48F4430F1E17B557E63A907E39EA2E6040F70E10E1B92A290DC951486E4A8A437254521B92A290DC951486E4A8A437254521B92A290DC95147F37CE93EF9D27DF3A4FBE749F7CE93EF9D27DF3A4FBE749F7CE93EF9D27DF3A4FBE749F7CE93A0000FEFF26800000000104923ADB0CB5B41CF397CCF3AB29DB94C7C7BFED0E73639EF0D9C7BC3671EF0D9C7BC3671EF0D9C7BC3671EF0D9C7BC3671EF0D9C7BC3671EF0D9C7BC3671EF0D9C7BC3671EF702670756666857040E0DBF58AA667CD8B28A8B8122339521531C1A6DA71522D67A018AFE3B5F7B0D05FDAEF331680000000000035517D07FCDAB8AE744A7B70E00375E751C05A33CC0258AC714919E615830D574FAE5A912C7EDA79E5F82056E970010C1E82B5BD1ED618184C0A48CAFD158C1C0771C889248AAFCEA955754D9EE176A7E0B5EEFC12C3DD44091CFA05FFDF47749EE7CFDBC30267DC4ECD01E5B62A86052E9349C81F93A9AA14C17B3074338C340C5B494854AF7A0FA94C594801624931E212C4F62F6CF9480FFA520417D2D97BEEA04CCE0E78A5445FB7F2069213E01A7C052852CA4341758E34824E63C4EDBEC9E3597597435E5167452FBCEA3A7A1AEBC51C99BF0F18E8D07CE4F7B55D2638E072CCB382EF6BBDFB7E140D56203F512C728E0BAB33B8F522C2E5466D5BBC94D15FBB779C112949C99C2C04F2B5ED416CB05A2DB4CD5A84FDD02EA47E8CE254B2A4EA3AA08E02AB9D7BF25F7ECCD0AA77ACA4AE1254E800599BA6B2B385CC6979307408E4863001874DC499F4D7B22F3446CD23E77FBB0BA2AFA93E9F0F96053FC4C85390A51151787423A6A91E393C3C6D3247DC83D1E72A54C3B0C4D233E757AA545A1578B36F09E3FD996FD2AA6221D43D40C755E35DFD39634931B4081D5088C40FEAF32E74C39EE60375F54E9562DC691587D37DB9331165427E7EEEAA8B25EBC6D11BDE108D7A91E031E875279CC643164DCF143E674E92814957D65A6690BADA705C1E8069275CC50252F5B6A2E2731E2013B85BA5A1D4B1B40BD9C3F83FAC8A9AD20E312110A13CDA11823CE2C68446BFC29F6ACF3919BE04B65C727A5533312724BDDEF170E9B1A2075772F4891952EA1C6202412AEACF1E01253A2F6F49BF0F14B158E45183A81E6A5381455DFA7652F61564EE164705C346C84D62AE0A0F9B16961CCC9D32429D5E24C08AAC1C67EC765E8ACF4B73640427F9C6F9D24510214B09D6A4A189CA4CADAB67EE1E6A0664934F01C0F09E3C0FFFB5EB9B5CA4B08E986DDCF5B6628C34983E8E188918822BB423075D9F5D963B6792177EE8ADB245325C2CDD3392B56E83428647A6E1D4409D1CD98B0FCFBB1B4AA69FCC0BE8DB50DBE80EC1FB93ABE171E68713E94562BD620B75B015543C2CB0C03031CD3575331D85DE4FF0BE271FB30F188A7298D03F470F33C8C6A516DDDF6A64318F9B0AEB28D78EAD4E88476B6F3F4E100295940C6E3BB5CFB91B75CF3BADB6E000C29F38B90FEC7DCFAAC69668E6C5A1F8113DB4EFB0EDA0D0FF861FEE6A6142E2D8BB4CAAF1E77E207FE36EBDF4A23BE0D660A2EF4123FE17C4AD7BEA0E4DF2EC0CDF24AD8F60778CA352CAEE52D5F16ED10945D0CF6FF27634069C20087EDDB5783AD54B9405F453B93CF0272E6AE6AA9993222C38DF1636B0720BE3C36356744C433137E75AAC4C9E03B1F4D678E8EE3AE22E089FF262EE7BE35D8C9A992BF8EDCA17336A69E01A72D57D230DFD7770DE40B395CDEC5ABFD2F123DE11A56F8F06E5EC554CB7B5DB11D0A1CA0F8167EA5A0DAF171C685BF3AD548EAA161298189F81EA8969DA6C5DA65578F3BFAD22425A21748D255358A316249B90D50391CF421F5F7418D81F593205A19A3F9D850E3C098BE399E4179EE927D386FE63218B26E78A2000EB73414BE9320CFEDD46847EF7BF6D6B7C9C8D4CBCD4A60828C1F7C415F6BE2AFC30C3FD582F8C2B74E42EBAFEE6DF083E7C2A5E7EFABFA65B788F9F0B67BEBE68AF025E9C0A2EB185D800B4261931DDE3941FBB934B32DF1629291B1C3AA89B3087413BB624785E2E4EFDC1A48B3D5B82B8880026F03389BC00000000000000000000')
WHERE foto_post = 0;

