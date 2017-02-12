drop table wojewodztwa cascade;
drop table powiaty cascade;
drop table gminy cascade;
drop table rzeki cascade;
drop table punkty_pomiarowe cascade;
drop table pomiary cascade;
drop table ostrzezenia cascade;

begin;

CREATE TABLE wojewodztwa (
    identyfikator INTEGER PRIMARY KEY,
    nazwa VARCHAR(30) NOT NULL
);
 
CREATE TABLE powiaty (
    identyfikator INTEGER PRIMARY KEY,
    nazwa VARCHAR(30) NOT NULL,
    id_wojewodztwa INTEGER NOT NULL REFERENCES wojewodztwa
);
 
CREATE TABLE gminy (
    identyfikator INTEGER,
    nazwa VARCHAR(30) NOT NULL,
    id_powiatu INTEGER NOT NULL,
    PRIMARY KEY (identyfikator),
    FOREIGN KEY (id_powiatu) REFERENCES powiaty
);
 
CREATE TABLE rzeki (
    id_rzeki INTEGER PRIMARY KEY,
    nazwa VARCHAR(30)
);
 
CREATE TABLE punkty_pomiarowe (
    id_punktu INTEGER PRIMARY KEY,
    nr_porzadkowy INTEGER,
    id_gminy INTEGER NOT NULL REFERENCES gminy,
    id_rzeki INTEGER NOT NULL REFERENCES rzeki,
    dlugosc_geogr FLOAT NOT NULL,
    szerokosc_geogr FLOAT NOT NULL,
    stan_ostrzegawczy INTEGER,
    stan_alarmowy INTEGER
);
 
CREATE TABLE pomiary (
    id_pomiaru INTEGER PRIMARY KEY,
    id_punktu INTEGER NOT NULL REFERENCES punkty_pomiarowe,
    czas_pomiaru TIMESTAMP NOT NULL,
    poziom_wody INTEGER NOT NULL
);
 
CREATE TABLE ostrzezenia (
    id_ostrzezenia INTEGER PRIMARY KEY,
    id_punktu INTEGER NOT NULL REFERENCES punkty_pomiarowe,
    czas_ostrzezenia TIMESTAMP NOT NULL,
    przekroczony_stan_ostrz INTEGER,
    przekroczony_stan_alarm INTEGER,
    zmiana_poziomu FLOAT
);

copy wojewodztwa from stdin with (null '', delimiter '|');
1|dolnośląskie
2|kujawsko-pomorskie
3|lubelskie
4|lubuskie
5|łódzkie
6|małopolskie
7|mazowieckie
8|opolskie
9|podkarpackie
10|podlaskie
11|pomorskie
12|śląskie
13|świętokrzyskie
14|warmińsko-mazurskie
15|wielkopolskie
16|zachodniopomorskie
\.

copy powiaty from stdin with (null '', delimiter '|');
1|Wrocław|1
2|Jelenia Góra|1
3|Legnica|1
4|Wałbrzych|1
5|bolesławiecki|1
6|dzierżoniowski|1
7|głogowski|1
8|górowski|1
9|jaworski|1
10|jeleniogórski|1
11|kamiennogórski|1
12|kłodzki|1
13|legnicki|1
14|lubański|1
15|lubiński|1
16|lwówecki|1
17|milicki|1
18|oleśnicki|1
19|oławski|1
20|polkowicki|1
21|strzeliński|1
22|średzki|1
23|świdnicki|1
24|trzebnicki|1
25|wałbrzyski|1
26|wołowski|1
27|wrocławski|1
28|ząbkowicki|1
29|zgorzelecki|1
30|złotoryjski|1
31|Bydgoszcz|2
32|Toruń|2
33|Włocławek|2
34|Grudziądz|2
35|aleksandrowski|2
36|brodnicki|2
37|bydgoski|2
38|chełmiński|2
39|golubsko-dobrzyński|2
40|grudziądzki|2
41|inowrocławski|2
42|lipnowski|2
43|mogileński|2
44|nakielski|2
45|radziejowski|2
46|rypiński|2
47|sępoleński|2
48|świecki|2
49|toruński|2
50|tucholski|2
51|wąbrzeski|2
52|włocławski|2
53|żniński|2
54|Lublin|3
55|Biała Podlaska|3
56|Chełm|3
57|Zamość|3
58|bialski|3
59|biłgorajski|3
60|chełmski|3
61|hrubieszowski|3
62|janowski|3
63|krasnostawski|3
64|kraśnicki|3
65|lubartowski|3
66|lubelski|3
67|łęczyński|3
68|łukowski|3
69|opolski|3
70|parczewski|3
71|puławski|3
72|radzyński|3
73|rycki|3
74|świdnicki|3
75|tomaszowski|3
76|włodawski|3
77|zamojski|3
78|Gorzów Wielkopolski|4
79|Zielona Góra|4
80|gorzowski|4
81|krośnieński|4
82|międzyrzecki|4
83|nowosolski|4
84|słubicki|4
85|strzelecko-drezdenecki|4
86|sulęciński|4
87|świebodziński|4
88|wschowski|4
89|zielonogórski|4
90|żagański|4
91|żarski|4
92|Łódź|5
93|Piotrków Trybunalski|5
94|Skierniewice|5
95|bełchatowski|5
96|brzeziński|5
97|kutnowski|5
98|łaski|5
99|łęczycki|5
100|łowicki|5
101|łódzki wschodni|5
102|opoczyński|5
103|pabianicki|5
104|pajęczański|5
105|piotrkowski|5
106|poddębicki|5
107|radomszczański|5
108|rawski|5
109|sieradzki|5
110|skierniewicki|5
111|tomaszowski|5
112|wieluński|5
113|wieruszowski|5
114|zduńskowolski|5
115|zgierski|5
116|Kraków|6
117|Nowy Sącz|6
118|Tarnów|6
119|bocheński|6
120|brzeski|6
121|chrzanowski|6
122|dąbrowski|6
123|gorlicki|6
124|krakowski|6
125|limanowski|6
126|miechowski|6
127|myślenicki|6
128|nowosądecki|6
129|nowotarski|6
130|olkuski|6
131|oświęcimski|6
132|proszowicki|6
133|suski|6
134|tarnowski|6
135|tatrzański|6
136|wadowicki|6
137|wielicki|6
138|Warszawa|7
139|Ostrołęka|7
140|Płock|7
141|Radom|7
142|Siedlce|7
143|białobrzeski|7
144|ciechanowski|7
145|garwoliński|7
146|gostyniński|7
147|grodziski|7
148|grójecki|7
149|kozienicki|7
150|legionowski|7
151|lipski|7
152|łosicki|7
153|makowski|7
154|miński|7
155|mławski|7
156|nowodworski|7
157|ostrołęcki|7
158|ostrowski|7
159|otwocki|7
160|piaseczyński|7
161|płocki|7
162|płoński|7
163|pruszkowski|7
164|przasnyski|7
165|przysuski|7
166|pułtuski|7
167|radomski|7
168|siedlecki|7
169|sierpecki|7
170|sochaczewski|7
171|sokołowski|7
172|szydłowiecki|7
173|warszawski zachodni|7
174|węgrowski|7
175|wołomiński|7
176|wyszkowski|7
177|zwoleński|7
178|żuromiński|7
179|żyrardowski|7
180|Opole|8
181|brzeski|8
182|głubczycki|8
183|kędzierzyńsko-kozielski|8
184|kluczborski|8
185|krapkowicki|8
186|namysłowski|8
187|nyski|8
188|oleski|8
189|opolski|8
190|prudnicki|8
191|strzelecki|8
192|Rzeszów|9
193|Krosno|9
194|Przemyśl|9
195|Tarnobrzeg|9
196|bieszczadzki|9
197|brzozowski|9
198|dębicki|9
199|jarosławski|9
200|jasielski|9
201|kolbuszowski|9
202|krośnieński|9
203|leski|9
204|leżajski|9
205|lubaczowski|9
206|łańcucki|9
207|mielecki|9
208|niżański|9
209|przemyski|9
210|przeworski|9
211|ropczycko-sędziszowski|9
212|rzeszowski|9
213|sanocki|9
214|stalowowolski|9
215|strzyżowski|9
216|tarnobrzeski|9
217|Białystok|10
218|Łomża|10
219|Suwałki|10
220|augustowski|10
221|białostocki|10
222|bielski|10
223|grajewski|10
224|hajnowski|10
225|kolneński|10
226|łomżyński|10
227|moniecki|10
228|sejneński|10
229|siemiatycki|10
230|sokólski|10
231|suwalski|10
232|wysokomazowiecki|10
233|zambrowski|10
234|Gdańsk|11
235|Gdynia|11
236|Słupsk|11
237|Sopot|11
238|bytowski|11
239|chojnicki|11
240|człuchowski|11
241|kartuski|11
242|kościerski|11
243|kwidzyński|11
244|lęborski|11
245|malborski|11
246|nowodworski|11
247|gdański|11
248|pucki|11
249|słupski|11
250|starogardzki|11
251|sztumski|11
252|tczewski|11
253|wejherowski|11
254|Katowice|12
255|Bielsko-Biała|12
256|Bytom|12
257|Chorzów|12
258|Częstochowa|12
259|Dąbrowa Górnicza|12
260|Gliwice|12
261|Jastrzębie-Zdrój|12
262|Jaworzno|12
263|Mysłowice|12
264|Piekary Śląskie|12
265|Ruda Śląska|12
266|Rybnik|12
267|Siemianowice Śląskie|12
268|Sosnowiec|12
269|Świętochłowice|12
270|Tychy|12
271|Zabrze|12
272|Żory|12
273|będziński|12
274|bielski|12
275|bieruńsko-lędziński|12
276|cieszyński|12
277|częstochowski|12
278|gliwicki|12
279|kłobucki|12
280|lubliniecki|12
281|mikołowski|12
282|myszkowski|12
283|pszczyński|12
284|raciborski|12
285|rybnicki|12
286|tarnogórski|12
287|wodzisławski|12
288|zawierciański|12
289|żywiecki|12
290|Kielce|13
291|buski|13
292|jędrzejowski|13
293|kazimierski|13
294|kielecki|13
295|konecki|13
296|opatowski|13
297|ostrowiecki|13
298|pińczowski|13
299|sandomierski|13
300|skarżyski|13
301|starachowicki|13
302|staszowski|13
303|włoszczowski|13
304|Olsztyn|14
305|Elbląg|14
306|bartoszycki|14
307|braniewski|14
308|działdowski|14
309|elbląski|14
310|ełcki|14
311|giżycki|14
312|gołdapski|14
313|iławski|14
314|kętrzyński|14
315|lidzbarski|14
316|mrągowski|14
317|nidzicki|14
318|nowomiejski|14
319|olecki|14
320|olsztyński|14
321|ostródzki|14
322|piski|14
323|szczycieński|14
324|węgorzewski|14
325|Poznań|15
326|Kalisz|15
327|Konin|15
328|Leszno|15
329|chodzieski|15
330|czarnkowsko-trzcianecki|15
331|gnieźnieński|15
332|gostyński|15
333|grodziski|15
334|jarociński|15
335|kaliski|15
336|kępiński|15
337|kolski|15
338|koniński|15
339|kościański|15
340|krotoszyński|15
341|leszczyński|15
342|międzychodzki|15
343|nowotomyski|15
344|obornicki|15
345|ostrowski|15
346|ostrzeszowski|15
347|pilski|15
348|pleszewski|15
349|poznański|15
350|rawicki|15
351|słupecki|15
352|szamotulski|15
353|średzki|15
354|śremski|15
355|turecki|15
356|wągrowiecki|15
357|wolsztyński|15
358|wrzesiński|15
359|złotowski|15
360|Szczecin|16
361|Koszalin|16
362|Świnoujście|16
363|białogardzki|16
364|choszczeński|16
365|drawski|16
366|goleniowski|16
367|gryficki|16
368|gryfiński|16
369|kamieński|16
370|kołobrzeski|16
371|koszaliński|16
372|łobeski|16
373|myśliborski|16
374|policki|16
375|pyrzycki|16
376|sławieński|16
377|stargardzki|16
378|szczecinecki|16
379|świdwiński|16
380|wałecki|16
\.

--nazwa from rivers & powiat random
copy gminy from stdin with (null '', delimiter '|');
1|wisla1|1
2|wisla2|20
3|odra1|45
4|odra2|65
5|warta|32
6|drawa|156
7|bug|360
8|narew|360
9|san|1
10|notec|1
11|pilica|232
12|wieprz|236
13|bobr|111
14|lyna|104
15|nysa luzycka|333
16|wkra|325
17|dunajec|15
18|brda|176
19|prosna|198
20|drweca|234
21|wislok|257
22|wda|245
23|nysa luzycka|378
24|wkra|321
25|dunajec|378
26|brda|321
27|prosna|20
28|drweca|376
29|wislok|183
30|wda|146
\.

--the longest
copy rzeki from stdin with (null '', delimiter '|');
1|Wisła
2|Odra
3|Warta
4|Bug
5|Narew
6|San
7|Noteć
8|Pilica
9|Wieprz
10|Bóbr
11|Łyna
12|Nysa Łużycka
13|Wkra
14|Dunajec
15|Brda
16|Prosna
17|Drwęca
18|Wisłok
19|Wda
20|Drawa
\.

-- gmina 6 never used & rzeka 20 never used
copy punkty_pomiarowe from stdin with (null '', delimiter '|');
1|1|1|1|50.1|50.11|550|600
2|2|1|1|51.2|40.31|550|600
3|3|1|1|52.3|30.13|550|600
4|4|2|1|53.4|20.14|600|650
5|5|2|1|54.5|10.15|600|650
6|6|2|1|55.6|50.16|600|650
7|7|3|2|56.7|40.51|300|350
8|8|3|2|57.8|30.61|300|350
9|9|4|2|58.9|20.41|450|500
10|10|4|2|59.11|10.11|450|500
11|11|4|2|60.12|50.31|450|500
12|12|5|3|61.13|60.01|250|300
13|13|5|3|62.14|70.21|250|300
14|14|5|3|63.15|80.41|200|250
15|15|5|3|64.16|90.91|200|250
16|16|7|4|65.17|100.31|650|700
17|17|7|4|66.18|50.14|600|650
18|18|8|5|67.19|60.17|350|400
19|19|9|6|68.20|70.19|450|500
20|20|10|7|69.1|80.14|200|250
21|21|11|8|70.2|90.15|400|450
22|22|12|9|10.3|100.10|350|400
23|23|13|10|11.4|50.51|500|550
24|24|14|11|12.5|51.61|600|650
25|25|15|12|13.6|52.18|450|500
26|26|16|13|14.7|53.10|550|600
27|27|17|14|15.8|54.01|300|350
28|28|18|15|16.9|55.21|500|550
29|29|19|16|17.10|50.21|550|600
30|30|20|17|18.11|51.51|500|550
31|31|21|18|19.12|52.91|600|650
32|32|22|19|20.13|53.18|600|650
33|33|23|12|21.14|54.31|650|700
34|34|24|13|22.15|55.31|250|300
35|35|25|14|23.16|56.31|200|250
36|36|26|15|24.17|57.41|250|300
37|37|27|16|25.18|58.10|400|450
38|38|28|17|26.19|59.16|550|600
39|39|29|18|27.20|51.14|650|700
40|40|30|19|28.31|52.12|350|400
\.

--only one for a day too much to make several
copy pomiary from stdin with (null '', delimiter '|');
1|1|2016-01-01 01:01:00|500
2|1|2016-01-02 01:01:00|600
3|1|2016-01-03 01:01:00|700
4|2|2016-01-04 02:02:01|500
5|2|2016-01-05 02:02:01|500
6|2|2016-01-06 02:02:01|500
7|3|2016-01-07 03:03:02|580
8|3|2016-01-08 03:03:02|570
9|3|2016-01-09 03:03:02|560
10|4|2016-02-10 04:04:03|550
11|4|2016-02-11 04:04:03|500
12|4|2016-02-12 04:04:03|610
13|5|2016-02-13 05:05:04|660
14|5|2016-02-14 05:05:04|660
15|5|2016-02-15 05:05:04|660
16|6|2016-02-16 06:06:05|550
17|6|2016-02-17 06:06:05|630
18|6|2016-02-18 06:06:05|700
19|7|2016-03-19 07:17:06|250
20|7|2016-03-20 07:17:06|260
21|7|2016-03-21 07:17:06|280
22|8|2016-03-22 08:18:17|310
23|8|2016-03-23 08:18:17|280
24|8|2016-03-24 08:18:17|310
25|9|2016-03-25 09:19:18|400
26|9|2016-03-26 09:19:18|430
27|9|2016-03-27 09:19:18|410
28|10|2016-04-28 10:10:19|550
29|10|2016-04-29 10:10:19|530
30|10|2016-04-30 10:10:19|460
31|11|2016-04-01 01:11:10|460
32|11|2016-04-02 01:11:10|440
33|11|2016-04-03 01:11:10|470
34|12|2016-04-04 02:12:11|200
35|12|2016-04-05 02:12:11|200
36|12|2016-04-06 02:12:11|210
37|13|2016-05-07 03:23:12|230
38|13|2016-05-08 03:23:12|250
39|13|2016-05-09 03:23:12|280
40|14|2016-05-10 04:24:23|180
41|14|2016-05-11 04:24:23|230
42|14|2016-05-12 04:24:23|260
43|15|2016-05-13 05:25:24|250
44|15|2016-05-14 05:25:24|220
45|15|2016-05-15 05:25:24|190
46|16|2016-06-16 06:26:25|630
47|16|2016-06-17 06:26:25|640
48|16|2016-06-18 06:26:25|660
49|17|2016-06-19 07:27:26|580
50|17|2016-06-20 07:27:26|590
51|17|2016-06-21 07:27:26|570
52|18|2016-06-22 08:28:27|340
53|18|2016-06-23 08:28:27|320
54|18|2016-06-24 08:28:27|330
55|19|2016-07-25 10:39:28|460
56|19|2016-07-26 10:39:28|460
57|19|2016-07-27 10:39:28|470
58|20|2016-07-28 11:30:29|180
59|20|2016-07-29 11:30:29|190
60|20|2016-07-30 11:30:29|170
61|21|2016-07-01 12:31:30|380
62|21|2016-07-02 12:31:30|410
63|21|2016-07-03 12:31:30|420
64|22|2016-08-04 13:32:31|320
65|22|2016-08-05 13:32:31|310
66|22|2016-08-06 13:32:31|280
67|23|2016-08-07 14:33:32|560
68|23|2016-08-08 14:33:32|560
69|23|2016-08-09 14:33:32|560
70|24|2016-08-10 15:34:33|540
71|24|2016-08-11 15:34:33|560
72|24|2016-08-12 15:34:33|530
73|25|2016-09-13 16:45:34|460
74|25|2016-09-14 16:45:34|430
75|25|2016-09-15 16:45:34|420
76|26|2016-09-16 17:46:35|500
77|26|2016-09-17 17:46:35|520
78|26|2016-09-18 17:46:35|540
79|27|2016-10-19 18:47:36|360
80|27|2016-10-20 18:47:36|370
81|27|2016-10-21 18:47:36|360
82|28|2016-10-22 19:48:47|510
83|28|2016-10-23 19:48:47|490
84|28|2016-10-24 19:48:47|520
85|29|2016-10-25 10:49:48|540
86|29|2016-10-26 10:49:48|530
87|29|2016-10-27 10:49:48|540
88|30|2016-10-28 11:40:49|510
89|30|2016-10-29 11:40:49|520
90|30|2016-10-30 11:40:49|490
91|31|2016-11-01 12:51:40|590
92|31|2016-11-02 12:51:40|580
93|31|2016-11-03 12:51:40|590
94|32|2016-11-04 13:52:41|590
95|32|2016-11-05 13:52:41|610
96|32|2016-11-06 13:52:41|630
97|32|2016-11-07 13:52:41|580
98|33|2016-11-08 14:53:42|640
99|33|2016-11-09 14:53:42|630
100|34|2016-12-10 15:54:53|240
101|34|2016-12-11 15:54:53|260
102|34|2016-12-12 15:54:53|260
103|34|2016-12-13 15:54:53|240
104|35|2016-12-14 16:55:54|190
105|35|2016-12-15 16:55:54|180
106|36|2016-12-16 17:56:55|240
107|36|2016-12-17 17:56:55|230
108|36|2016-12-18 17:56:55|260
109|37|2016-01-19 18:07:56|390
110|37|2016-01-20 18:07:56|390
111|37|2016-01-21 18:07:56|380
112|38|2017-01-22 20:08:57|560
113|38|2017-01-23 20:08:57|570
114|38|2017-01-24 20:08:57|580
115|39|2017-01-25 21:09:58|640
116|39|2017-01-26 21:09:58|620
117|39|2017-01-27 21:09:58|660
118|40|2017-02-18 22:01:59|320
119|40|2017-02-19 22:01:59|340
120|40|2017-02-20 22:01:59|310
\.

copy ostrzezenia from stdin with (null '', delimiter '|');
1|1|2016-01-02 01:01:00|50||0.2
2|1|2016-01-03 01:01:00|150|100|0.17
3|3|2016-01-07 03:03:02|30||0
4|3|2016-01-08 03:03:02|20||0.02
5|3|2016-01-09 03:03:02|10||0.02
6|4|2016-02-12 04:04:03|10||0.22
7|5|2016-02-13 05:05:04|60|10|0
8|5|2016-02-14 05:05:04|60|10|0
9|5|2016-02-15 05:05:04|60|10|0
10|6|2016-02-17 06:06:05|30||0.15
11|6|2016-02-18 06:06:05|100|50|0.11
12|8|2016-03-22 08:18:17|10||0
13|8|2016-03-24 08:18:17|10||0.11
14|10|2016-04-28 10:10:19|100|50|0
15|10|2016-04-29 10:10:19|80|30|0.04
16|10|2016-04-30 10:10:19|10||0.13
17|11|2016-04-01 01:11:10|10||0
18|11|2016-04-03 01:11:10|20||0.07
19|13|2016-05-09 03:23:12|30||0.12
20|14|2016-05-11 04:24:23|30||0.28
21|14|2016-05-12 04:24:23|60|10|0.13
22|15|2016-05-13 05:25:24|50||0
23|15|2016-05-14 05:25:24|20||0.14
24|16|2016-06-18 06:26:25|10||0.03
25|19|2016-07-25 10:39:28|10||0
26|19|2016-07-26 10:39:28|10||0
27|19|2016-07-27 10:39:28|20||0.02
28|21|2016-07-02 12:31:30|10||0.08
29|21|2016-07-03 12:31:30|20||0.02
30|23|2016-08-07 14:33:32|60|10|0
31|23|2016-08-08 14:33:32|60|10|0
32|23|2016-08-09 14:33:32|60|10|0
33|25|2016-09-13 16:45:34|10||0
34|27|2016-10-19 18:47:36|60|10|0
35|27|2016-10-20 18:47:36|70|20|0.03
36|27|2016-10-21 18:47:36|60|10|0.03
37|28|2016-10-22 19:48:47|10||0
38|28|2016-10-24 19:48:47|20||0.06
39|30|2016-10-28 11:40:49|10||0
40|30|2016-10-29 11:40:49|20||0.02
41|32|2016-11-05 13:52:41|10||0.03
42|32|2016-11-06 13:52:41|30||0.03
43|34|2016-12-11 15:54:53|10||0.08
44|34|2016-12-12 15:54:53|10||0
45|38|2017-01-22 20:08:57|10||0
46|38|2017-01-23 20:08:57|20||0.02
47|38|2017-01-24 20:08:57|30||0.02
48|39|2017-01-27 21:09:58|10||0.06
\.

commit;
