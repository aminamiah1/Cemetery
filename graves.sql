BEGIN TRANSACTION;
DROP TABLE IF EXISTS "approved";
CREATE TABLE IF NOT EXISTS "approved" (
	"ID" INTEGER NOT NULL,
	"name" TEXT,
	"geoCode" TEXT,
	"lat" TEXT,
	"long" TEXT,
	"info" TEXT,
	"picPath" TEXT DEFAULT 'static/img/noImage.png',
	PRIMARY KEY("ID" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "submitted";
CREATE TABLE IF NOT EXISTS "submitted" (
	"ID" INTEGER NOT NULL UNIQUE,
	"graveName" TEXT,
	"graveInfo" TEXT,
	"graveLocation" TEXT,
	"userName" TEXT,
	"userEmail" TEXT,
	"dateSubmitted" TEXT,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
INSERT INTO "approved" (
		"ID",
		"name",
		"geoCode",
		"lat",
		"long",
		"info",
		"picPath"
	)
VALUES (
		1,
		'Mary Grant',
		'FCD 45. 25',
		'51.58247',
		'-3.01658',
		'Aged 52 - 17th November 1868 - Mary Grant was bayonetted outside her home in Newport by soldiers of 23rd Royal Welsh Fusiliers following a "riot" outside the town hall during the elections. A large crowd had gathered outside the town hall where tensions were high, windows were being smashed and the mayor ordered the soldiers to break up the crowd. The crowd split with one section heading north towards Baneswell, as the crowd were being chased by the soldiers with their bayonets drawn along Baneswell Road, Mary Grant was attempting to step into their home but was stabbed as the soldiers ran went by and was killed instantly, her son Charles also received a fatal wound that led to his death seven months later. (Aged 27',
		'static/img/noImage.png'
	),
	(
		2,
		'Florence Johnstone',
		'CON D.12.158',
		'51.58368',
		'-3.01688',
		'Florence Valentine Johnstone was born in Newport in 1893. When WW1 broke out her older brother John joined the army. He died at the Battle of Loos on 2nd October 1915. He has no known grave and he is remembered on the Loos memorial in Dud Corner Cemetery, together with 20,500 others.In 1914 the British Army had not fully appreciated how important the role artillery was going to be and by 1915 there was a serious shortage of shells. The government responded by passing The Munitions of War Act 1915, which meant that they had a closer oversight of what was going on, and a new Ministry of Munitions, was established. This new Act encouraged the employment of women in the factories thus freeing up men to go to the front. By June 1917 80% of weapons and munitions were being produced by women, a workforce of which was to rise to 950,000. These women became known as either the “Munitionettes” or if they worked in the factories packing the shells with explosives as "Canaries" (due to the high levels of sulphur they were exposed to). Florence responded to the call and moved to Coventry in 1916 where around 30,000 men, women and children were employed in the Ordnance Factory. In January 1918 she was promoted to a Charge Hand but on 5th February, whilst working on a fuse, it exploded causing terrible injuries and killing her instantly.',
		'static/img/florenceJohnstone.jpg'
	),
	(
		3,
		'Annie Brewer',
		'FCD 16.201',
		'51.58213',
		'-3.02037',
		'Annie Brewer was born in Newport in 1874 and after leaving school trained to be a nurse, at the outbreak of WW1 she was working in France and immediately volunteered to serve as a nurse with the British Army. She was rejected as not having the right qualifications however the French Army were only to pleased to list her services. She rapidly rose through the ranks eventually becoming a Commandant Major having run numerous hospitals throughout the war. She would drive ambulances to the front line to pick up wounded soldiers and was constantly putting herself in danger to ensure that others survived. For her service and bravery Annie Brewer became one of the most highly decorated nurses during WW1 being only the second woman to receive France highest award for bravery (the equivalent of Britains Victoria Cross) The National Order of the Legion of Honour. Once the war had ceased Annie Brewer established a feeding station In Germany. In 1921 her mother became ill and she returned to Newport to care for her, however she became ill herself and died on 30th January 1921.During her time on the Western Front she compiled a remarkable photographic collection which featured in a BBC Wales television programme in 2014.',
		'static/img/noImage.png'
	),
	(
		4,
		'John Algie',
		NULL,
		'51.58220',
		'-3.01523',
		'Born in Newport 1872. Began work as an office boy Mr Lyndon Moore for three years before taking employment for five years with Mr John Young. In 1891 commenced practice as a public accountant but in 1896 he moved to South Africa for health reasons following difficulties with his breathing. Initially he took a job as a journalist in Port Elizabeth but moved to Mafeking where his health improved. He was appointed the town clerk in 1897 and he held the post during the famous ‘Siege’ during the  Second Boar War (1899 -1902). It was during the siege that the commander of the British forces Colonel Robert Baden Powell , developed the principles that later went onto to create The Boy Scout movement. John Algie kept a diary of the siege which was never published and is now held in the town’s museum. Eventually his lung condition returned and he moved home to Newport where he died aged 44.',
		'static/img/noImage.png'
	),
	(
		5,
		'Dennis O''Neill',
		NULL,
		'51.58016',
		'-3.02318',
		'Dennis O’Neill was born in Newport on 3rd March 1932. On 30 May 1944, Dennis aged 12 together with his two younger brothers Terry and Freddie were taken into care by Newport County Borough , Dennis and Terry were sent to live with Reginald and Esher Gough on their remote farm in Hope Valley, Shropshire, whilst Freddie was placed with a nearby family. During the next few months both Dennis and Terry were to suffer at the cruel and unkind hands of the Goughs, following a terrible beating and period of starvation Dennis passed away on 9th January 1945. The full horrifying story was eventually published in a book by Terry called “Someone to love”As a direct result of this terrible event the 1948 Children Act was introduced and Agatha Christie play',
		'static/img/noImage.png'
	),
	(
		6,
		'Harry Mills',
		NULL,
		'51.58034',
		'-3.02128',
		'This story came to light a few years ago ,when the then local MP Paul Flynn, wrote to the chemical manufacturers Monsanto’s who had had, for many years, a factory in the city. He was enquiring about a completely separate subject, but amongst the papers he was sent was the report of Harry Mills death in 1943, which was not reported at the time. Around the end of 1942, 12 year old Harry Mills of 10 Maesglas Grove, Newport was playing with a group of friends on an old refuse tip near to the North Dock, south of the city. They came across some canisters and somehow or other the boys got splashed with some of their contents. Returning home to wash it off Harry became very ill and was attempted to hospital where he died a few days later on 2nd January 1943.',
		'static/img/noImage.png'
	),
	(
		7,
		'Alfred Biggs Rodaway',
		NULL,
		'51.58078',
		'-3.02000',
		'On the morning of 7th January 1864 PC Rodaway  was on his beat in the docklands of Newport, he found a drunken sailor and escorted him back to the local Police Station where he spent the night in a cell. PC Rodaway returned to his beat, but was never seen alive again. His body was discovered the following day  in the River Usk and his watch had stopped at 4 am, which the coroner assumed was the time he fell to his death. The circumstances were never clarified and how he managed to fall remains a mystery. His fellow officers raised the funds amongst themselves to have a stone placed on the grave.',
		'static/img/noImage.png'
	),
	(
		8,
		'John Sicolo',
		NULL,
		'51.58114',
		'-3.01805',
		'9th March 1944 - 14th march 2010John Sicolo began his working career as a merchant seaman before opening a restaurant in Clarence Place, Newport with his wife called the Cedars, when the building next door became vacant he extended into it and turned it into a night club called El Seicos . Modelling it on the downbeat art students union building on Stow Hill Sicolo went on to feature some of the top up and coming bands in the world. It''s claimed that Kurt Cobain of Nirvana proposed to Courtney Love whilst visiting the club. Oasis , Stone Roses, Manic Street Preachers all played here before hitting the big time. Joe Strummer from the Clash choose to play her in the later days of his career as a thank you to Newport for being such an inspiration to his musical development.  El Seico’s eventually transmuted into TJ’s and became known throughout the world as the place to play earning Newport the title of “the new Seattle”. Sicolo died in 2011 aged 66',
		'static/img/noImage.png'
	),
	(
		9,
		'Pearce Blackborow',
		NULL,
		'51.58153',
		'-3.01597',
		'Pearce Blackborow was born in Newport in 1896 and at an early age took to the sea ending up in South America on his first voyage. At the age of 18 he slipped aboard the ‘Endurance'' as a stowaway in Buenos Aires and found himself in the adventure of a lifetime. He had become part of Ernest Shackleton’s ill-fated 1914 -1917 Trans- Artic Expedition. Before the expedition in the South Pole began the ‘Endurance’ became trapped in the ice in the Weddell Sea and the crew abandoned ship. Eventually making it to Elephant Island where they waited to be rescued, after Shackleton and a small party set off in a small boat in April 1916. Here they remained until August living off seal meat. It was during this time that Blackborow lost a foot to gangrene, eventually he returned to Newport where he worked at a boatman in the town docks until he died in 1949 at the age of 53.',
		'static/img/noImage.png'
	),
	(
		10,
		'Eleanor Darby',
		'FCD 33. 8',
		'51.58290',
		'-3.01578',
		'On the 15th May 1864 the bodies of Eleanor Darby and her son John were recovered from the Mill Pond in Newport, it transpired that Eleanor had taken her own life and in doing so had taken that of her three year old child. Eleanor was 44 years old and had been happy married for 23 years to John a blacksmith of the town, they had numerous children but around twelve months before her death they had lost a son and from then onwards it appears she slipped into what we would now understand as a depressive illness. It seems that things came to a head following the death of her sister who for some time had been giving her a helping hand with the family. Left on her own it seems that her mental health deteriorated to such an extent that she slipped out with her young son, in the early hours of the morning and tragically took both their lives.',
		'static/img/noImage.png'
	);
INSERT INTO "submitted" (
		"ID",
		"graveName",
		"graveInfo",
		"graveLocation",
		"userName",
		"userEmail",
		"dateSubmitted"
	)
VALUES (
		1,
		'Example Name',
		'Example Story',
		'Example Location',
		'Toby Nott',
		'email@user.com',
		'2021-12-09-17:56'
	);
COMMIT;