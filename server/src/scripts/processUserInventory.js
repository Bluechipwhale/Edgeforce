import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const rawTSV = `Item	Quantity	Location of Item	Condition	Shelf Number
Kenstar brown carton filled with light equipments	1	Warehouse Shelves	Not specified	eestr001
Sac filled with pots and covers	1	Warehouse Shelves	Not specified	eestr002
white banner sheeet	1	Warehouse Shelves	Not specified	eestr002
Metal grinding sheet	2	Warehouse Shelves	Not specified	eestr002
Black rope	1	Warehouse Shelves	Not specified	eestr002
Extension cable reel	2	Warehouse Shelves	Not specified	eestr003
Metal grinding sheet	4	Warehouse Shelves	Not specified	eestr003
Sac with water pump	4 pumps	Warehouse Shelves	Not specified	eestr003
Half engine	1	Warehouse Shelves	Not specified	eestr004
Open screw box	1	Warehouse Shelves	Not specified	eestr004
Black Sac filled with parts		Warehouse Shelves	Not specified	eestr004
square green woods	12	Warehouse Shelves	Not specified	eestr006
rectangular wood	7	Warehouse Shelves	Not specified	eestr006
Priemier cool shield boards	7	Warehouse Shelves	Not specified	eestr006
Black pillow	1	Warehouse Shelves	Not specified	eestr006
High tension cables red & blue		Warehouse Shelves	Not specified	eestr006
Frypans	3	Warehouse Shelves	Not specified	eestr007
Open welding electrodes box	1 box	Warehouse Shelves	Not specified	eestr007
red gazebo cover cloth	1	Warehouse Shelves	Not specified	eestr007
Electrical Meter box	1	Warehouse Shelves	Not specified	eestr007
Golden rods	11	Warehouse Shelves	Not specified	eestr002
White pillows cases Veleta	2	Warehouse Shelves		eestr007
Veleta Black plastic cup bowls	5	Warehouse Shelves		eestr007
Paint roller brush	1	Warehouse Shelves	Not specified	eestr007
mamador banner	5	Warehouse Shelves	Not specified	eestr008
Dangote sac filled with white wood veleta		Warehouse Shelves		eestr008
trade convention	9	Warehouse Shelves	Not specified	eestr008
Gloss paint small container	1	Warehouse Shelves	Not specified	eestr008
2 brown box filled filled with black base	6 pieces each	Warehouse Shelves	Not specified	eestr008
1 open brown box filled with black base with a funnel	2 pieces	Warehouse Shelves	Not specified	eestr008
vechile tyre with two small with box in it	2	Warehouse Shelves	Not specified	eestr009
Brown boxes filled with golden rods and bases	3	Warehouse Shelves	Not specified	eestr010
Black plastic container	1	Warehouse Shelves	Not specified	eestr010
Golden rods in bubble wraps	4	Warehouse Shelves	Not specified	
feather banner	2	Warehouse Shelves	good	
White bag filled with veleta gele	1	Warehouse Shelves		eestr011
veleta rug	2	Warehouse Shelves		eestr011
Veleta banner	4	Warehouse Shelves		eestr011
Wooden design wrap mat	1	Warehouse Shelves	Not specified	eestr009
flat light bar	1	Warehouse Shelves	Not specified	eestr011
silver flat metal	2	Warehouse Shelves	Not specified	eestr011
water fan	1	Warehouse Shelves	good	eestr012
Brown boxes filled with black bases	3	Warehouse Shelves	Not specified	eestr012
vechile headlights	2	Warehouse Shelves	Not specified	eestr013
Pepsi Gazebo cover	1	Warehouse Shelves	Not specified	eestr013
pot with glass	7	Warehouse Shelves	Not specified	eestr014
golden iron	1	Warehouse Shelves	Not specified	eestr014
baby colorful fence wall	1	Warehouse Shelves	Not specified	eestr014
White baby fence box carton	1	Warehouse Shelves	Not specified	eestr014
Brown box filled with golden metal rods	1	Warehouse Shelves	Not specified	eestr014
Celotaped Brown box	2	Warehouse Shelves	Not specified	eestr015
Golden pole	2	Warehouse Shelves		eestr015
Shower rods	7	Warehouse Shelves	Not specified	eestr015
golden base	14 pieces	Warehouse Shelves	good	eestr016
decoration cloth		Warehouse Shelves	Not specified	eestr016
flat golden base	4	Warehouse Shelves	Not specified	eestr016
cone shape golden base	8	Warehouse Shelves	Not specified	eestr016
Gloss paint small container	1	Warehouse Shelves	Not specified	eestr016
Black Sac filled with base	1	Warehouse Shelves	Not specified	eestr016
Checked sac filled with cloth	1	Warehouse Shelves	Not specified	eestr016
Dangoted sac filled to half with nails	1	Warehouse Shelves	Not specified	eestr016
golden stand	2 set	Warehouse Shelves	good	eestr017
Golden base	9	Warehouse Shelves	Not specified	eestr017
Brown box filled with golden metal base	1	Warehouse Shelves	Not specified	eestr017
Prize check	1	Warehouse Shelves	Not specified	eestr017
Spraying machine	1	Warehouse Shelves	good	eestr018
plastic roof	4 pieces	Warehouse Shelves	good	eestr018
Christmas tree	1	Warehouse Shelves	Not specified	eestr018
Open brown box filled with base	1	Warehouse Shelves	Not specified	eestr018
ariston gazebo	1	Warehouse Shelves	good	eestr019
red gazebo cover	1	Warehouse Shelves	good	eestr019
Plastic chair cones	4	Warehouse Shelves	Not specified	eestr019
Sac filled with pump equipments	1	Warehouse Shelves	Not specified	eestr019
Christmas Decorations	2	Warehouse Shelves	Not specified	eestr019
Metal rod &Shower rod	4	Warehouse Shelves	Not specified	eestr019
Roll of sanding paper	1	Warehouse Shelves	Not specified	eestr019
Open box filled with pipe & blumbing stuff	1	Warehouse Shelves	Not specified	eestr019
plastic seating stool base	23 pieces	Warehouse Shelves	Not specified	eestr020
plastic seating stool top	3 pieces	Warehouse Shelves	Not specified	eestr020
Plastic chair cones	24	Warehouse Shelves	Not specified	eestr020
Plastic chair cones cover	7	Warehouse Shelves	Not specified	eestr020
Plastic black base	1	Warehouse Shelves	Not specified	eestr021
Cooler cover	1	Warehouse Shelves	Not specified	eestr021
Black sac filled with carex cap	1	Warehouse Shelves	Not specified	eestr021
christmas decorations	1	Warehouse Shelves	Not specified	eestr022
christmas decorations		Warehouse Shelves	Not specified	eestr022
sack full of carex Bthing glove	1	Warehouse Shelves	good	eestr023
stage light	2	Warehouse Shelves	unknown	eestr024
cecamix white cement	1	Warehouse Shelves	good	eestr024
stage extension	1	Warehouse Shelves	unknown	eestr024
water seal white	5 pieces	Warehouse Shelves	Not specified	eestr024
electrical items (general)		Warehouse Shelves	Not specified	eestr024
plug-in meters	4 pairs	Warehouse Shelves	Not specified	eestr024
adhesive	1	Warehouse Shelves	Not specified	eestr024
sam paper	1	Warehouse Shelves	good	eestr025
gloss paint small container	2	Warehouse Shelves	unknown	eestr025
vstar	2	Warehouse Shelves	good	eestr025
platerack	1	Warehouse Shelves	good	eestr025
carex bathing gloves	1 bag	Warehouse Shelves	Not specified	eestr025
wash hand basin stand	2	Warehouse Shelves	Not specified	eestr025
keg	1	Warehouse Shelves	Not specified	eestr025
pop screeding bucket	1	Warehouse Shelves	Not specified	eestr025
tiny paint bucket	2	Warehouse Shelves	Not specified	eestr025
value plus satin 20l	3	Warehouse Shelves	unknown	eestr026
vstar	3	Warehouse Shelves	good	eestr026
vstar	1	Warehouse Shelves	notgood	eestr026
wash hand basin stand	5	Warehouse Shelves	Not specified	eestr026
paint bucket	3	Warehouse Shelves	Not specified	eestr026
Dangote sac filled with white wood	1	Warehouse Shelves	Not specified	
stand with 2 sure long banner	1	Warehouse Shelves	Not specified	eestr027
Mousuf box filled with carex body vest in a sac		Warehouse Shelves	Not specified	eestr027
big fan	2	Warehouse Shelves	Not specified	eestr027
black travelling box	1	Warehouse Shelves	Not specified	eestr027
Torn sac filled with light & electrical components	1	Warehouse Shelves	Not specified	eestr027
mamador gazebo cover	2	Warehouse Shelves	good	eestr028
black table cover	5	Warehouse Shelves	good	eestr028
white table cover	4	Warehouse Shelves	good	eestr028
premiere cool stay confident jacket	1 bag	Warehouse Shelves	good	eestr028
ghana-must-go bag (full)	1	Warehouse Shelves	Not specified	eestr028
sac of mamador cloth	1	Warehouse Shelves	Not specified	eestr028
sac of silver rods and rolled metal strip	1	Warehouse Shelves	Not specified	eestr028
tied check-pattern sac	1	Warehouse Shelves	Not specified	eestr028
sac of mamador funnel and rolled cable	1	Warehouse Shelves	Not specified	eestr028
bag full of yellow sieve	6	Warehouse Shelves	good	eestr029
bag half full yellow seive	2	Warehouse Shelves	good	eestr029
bag full of yellow sieve	4	Warehouse Shelves	Not specified	eestr030
Box filled with ceiling lights	1	Warehouse Shelves	Not specified	eestr030
Box full of cutlery	2	Warehouse Shelves	good	eestr031
premiere cool box	8	Warehouse Shelves	5 damaged	eestr031
green metal sheets in brown carton	1	Warehouse Shelves	Not specified	eestr031
microwave box filled with premeir cool white plastic box	1	Warehouse Shelves	Not specified	eestr031
Bag full of cutlery	1	Warehouse Shelves	good	eestr032
kitchen bag of spoons	1	Warehouse Shelves	Not specified	eestr032
handheld turning machine	1	Warehouse Shelves	Not specified	eestr032
Stella cloth and equipments in baco bag		Warehouse Shelves	Not specified	eestr032
electrical cables		Warehouse Shelves	Not specified	eestr032
paint-sized bucket	1	Warehouse Shelves	Not specified	eestr032
keg	1	Warehouse Shelves	Not specified	eestr032
bag full of yellow sieve	2	Warehouse Shelves	Not specified	eestr033
half bag of yellow sieve	2	Warehouse Shelves	Not specified	eestr033
bag of mamador spoons and cartons	1	Warehouse Shelves	Not specified	eestr033
black bucket filled with carex books	1	Warehouse Shelves	Not specified	eestr033
bag full of yellow sieve	3	Warehouse Shelves	Not specified	eestr034
bags of mamador o-spoon	3	Warehouse Shelves	Not specified	eestr034
bags of yellow sieve spoons	3	Warehouse Shelves	Not specified	eestr034
nino leuten light holder	1	Warehouse Shelves	one cup damaged	eestr035
Big green industrial fans	2	Warehouse Shelves	Not specified	eestr035
black bucket	54	Warehouse Shelves	Not specified	eestr036
purple plastic bow	23	Warehouse Shelves	Not specified	eestr036
bow / plastic bows	6	Warehouse Shelves	Not specified	eestr036
big pot	2	Warehouse Shelves	Not specified	eestr036
saw	1	Warehouse Shelves	not good	eestr036
plastic bucket	48	Warehouse Shelves	Not specified	eestr036
sac full of carex books	1	Warehouse Shelves	Not specified	eestr036
bowls		Warehouse Shelves	Not specified	eestr036
pots		Warehouse Shelves	Not specified	eestr036
Stella cloth and equipments in baco bag		Warehouse Shelves	Not specified	eestr036
buckets		Warehouse Shelves	Not specified	eestr036
notebooks		Warehouse Shelves	Not specified	eestr036
bag of small white plastic	1	Warehouse Shelves	Not specified	eestr037
carex handheld boards	1	Warehouse Shelves	Not specified	eestr037
cover	1	Warehouse Shelves	Not specified	eestr037
sieve mamador yellow	1 bag	Warehouse Shelves	Not specified	eestr038
white bag (sumitoto) of yellow handle sieves	1	Warehouse Shelves	Not specified	eestr038
white nylon of yellow sieved spoons	1	Warehouse Shelves	Not specified	eestr038
bags of sieved spoons	2	Warehouse Shelves	Not specified	eestr038
Christmas decorations	1	Warehouse Shelves	Not specified	eestr039
Metal racks	3	Warehouse Shelves	Not specified	eestr040
Grey sac filled local sponge threads	1	Warehouse Shelves	Not specified	eestr040
cooking spoons	2 cartons	Warehouse Shelves	Not specified	eestr041
Mamador gazebo cover	1	Warehouse Shelves	Not specified	eestr042
gazebo stand (foldable)	1	Warehouse Shelves	Not specified	eestr042
white rods		Warehouse Shelves	Not specified	eestr042
White Gazebo stand	1	Warehouse Shelves	Not specified	eestr042 and 047
Gazebo stand	1	Warehouse Shelves	Not specified	eestr043
Red picnic table and chairs case	2	Warehouse Shelves	Not specified	Eestr043
mat (grey color)	1	Warehouse Shelves	Not specified	eestr043
set-up equipment & collapsable stand		Warehouse Shelves	Not specified	eestr043
wooden 2sure soap / 2sure mockup	2	Warehouse Shelves	Not specified	eestr044
plastic perfecct proposal	1	Warehouse Shelves	Not specified	eestr044
morning resh display stand	1	Warehouse Shelves	Not specified	eestr044
wooden 2sure soap mascot	2	Warehouse Shelves	good	eestr044
Display stand	3	Warehouse Shelves	Not specified	eestr044
hand wash ceramics for toilet	2	Warehouse Shelves	Not specified	eestr045
jameson plastic cup	3rolls	Warehouse Shelves	Not specified	eestr045
ceramic bowls		Warehouse Shelves	Not specified	eestr045
hand wash ceramics for toilet / ceramic bowls	2	Warehouse Shelves	Not specified	eestr046
2sure Gazebo cover	1	Warehouse Shelves	Not specified	eestr046
Pepsi Gazebo cover	1	Warehouse Shelves	Not specified	eestr046
Black banner	1	Warehouse Shelves	Not specified	eestr046
gazebo covers		Warehouse Shelves	Not specified	eestr046
Flag pole set	1	Warehouse Shelves	Not specified	eestr047
gazebo stand (foldable)	1	Warehouse Shelves	Not specified	eestr047
big seatable pillow / 2sure pillow	3	Warehouse Shelves	Not specified	eestr050
small seatable pillow / throw pillows	5	Warehouse Shelves	Not specified	eestr051
Jameson throw pillow	2	Warehouse Shelves	Not specified	eestr051
2sure pillow (additional)	2	Warehouse Shelves	Not specified	eestr051
big seatable pillow / premier cool bar shaped pillow	3	Warehouse Shelves	Not specified	eestr052
big seatable pillow	2	Warehouse Shelves	Not specified	eestr053
Jameson throw pillow	2	Warehouse Shelves	Not specified	eestr053
Roll up banner silver color	2	Warehouse Shelves	Not specified	Eestr053
Flag pole	1	Warehouse Shelves	Not specified	eestr053
premiere cool gazebo cover	4	Warehouse Shelves	Not specified	eestr054
gazebo cover	1	Warehouse Shelves	Not specified	eestr054
gazebo cover	1	Warehouse Shelves	Not specified	eestr055
big gazebo	1	Warehouse Shelves	Not specified	eestr056
gazebo cover	1	Warehouse Shelves	Not specified	eestr056
gazebo stand	1	Warehouse Shelves	Not specified	eestr057
cushion baby toy	1	Warehouse Shelves	Not specified	eestr057
Green atroturf	1	Warehouse Shelves	good	eestr059
red atroturf	1	Warehouse Shelves	good	eestr059
green atroturf	1	Warehouse Shelves	good	eestr059
Astroturf green	1	Warehouse Shelves	Not specified	eestr059
wires	6	Warehouse Shelves	Not specified	eestr061
lights	5	Warehouse Shelves	Not specified	eestr061
Rendiel	2	Warehouse Shelves	good	Eestr066 to 069
Christmas tree 8 inches	1	Warehouse Shelves	good	Eestr066 to 070
Christmas tree 10 inches	1	Warehouse Shelves	good	Eestr066 to 071
Snow man	2	Warehouse Shelves	good	Eestr066 to 072
Christmas cap	10	Warehouse Shelves	good	Eestr066 to 073
Christmas flower blue with white stripe	35	Warehouse Shelves	good	Eestr066 to 074
Christmas flower green	23	Warehouse Shelves	good	Eestr066 to 075
Christmas flower red	6	Warehouse Shelves	good	Eestr066 to 076
Christmas flower red and green together	1	Warehouse Shelves	good	Eestr066 to 077
Christmas tree dark green	1	Warehouse Shelves	good	Eestr066 to 078
Christmas box	10	Warehouse Shelves	good	Eestr066 to 079
Metallic Christmas tree	3	Warehouse Shelves	good	Eestr066 to 080
Shades of blue flower	15	Warehouse Shelves	good	Eestr066 to 081
Shades of red	11	Warehouse Shelves	good	Eestr066 to 082
Shades of pink flower	2	Warehouse Shelves	good	Eestr066 to 083
Hanging Christmas decor	3	Warehouse Shelves	good	Eestr066 to 084
Condemned door	1	Warehouse Shelves	not good	Unassigned
Elepaq generator	2	Warehouse Shelves	new	Unassigned
Black Thick mat		Warehouse Shelves	Not specified	Unassigned
Valeeta Cone	6	Warehouse Shelves	Not specified	Unassigned
Veleta Gele	8	Warehouse Shelves	Not specified	Unassigned
Red gazebo on the floor	1	Warehouse Shelves	Not specified	Unassigned
Cardboard	9	Maryland Office Side		
Inn Chair	19	Maryland Office Side		
Wheel barrow	2	Maryland Office Side		
White Cardboard	2	Maryland Office Side		
Fan without stand	1	Maryland Office Side		
Wood	72	Maryland Office Side		
Big bread	1	Maryland Office Side		
Table	7	Maryland Office Side		
Wood design table	1	Maryland Office Side		
Iron stand Design	2	Maryland Office Side		
Viva body Slimmer	1	Maryland Office Side		
Spoon	28 packs	Maryland Office Side		
Spliot fan	4	Maryland Office Side		
Tomato Jos board	1	Maryland Office Side		
Game roll	1	Maryland Office Side		
Car sign	1	Maryland Office Side		
Hand cleaning board	1	Maryland Office Side		
Iron display	2	Maryland Office Side		
Cable reel	1	Maryland Office Side		
Iron case	2 sets	Maryland Office Side		
Bucket	1	Maryland Office Side		
Cupboard Brown	8	Maryland Office Side		
Black steel stool without seat head	18	Maryland Office Side		
Wheel barrow	2	Maryland Office Side		
Ox Fan blade and cage	1	Maryland Office Side		
Through History board	1	Maryland Office Side		
Green wood riser	1	Maryland Office Side		
Green box prop	4	Maryland Office Side		
Green malaria hand prop	11	Maryland Office Side		
Palette wooden	5	Maryland Office Side		
Used wooden pieces prop stash	17	Maryland Office Side		
Open black plastic box	1	Maryland Office Side		
wooden brown cupboard	1	Maryland Office Side		
Rope latch	2	Maryland Office Side		
Plywood	3	Maryland Office Side		
Rubberfloor	2	Maryland Office Side		
Blue metal tripod	1	Maryland Office Side		
Body slimmer machine	1	Maryland Office Side		
Fan mist machine	1	Maryland Office Side		
Antique wooden chair	1	Maryland Office Side		
Table set plastics	6	Maryland Office Side		
Blue rug	1	Maryland Office Side		
Spoon packs	21	Maryland Office Side		
Fan base	4	Maryland Office Side		
Drawer and cupboard	2	Maryland Office Side		
Old brown knitlike rug	1	Maryland Office Side		
Used wooden pieces	19	Maryland Office Side		
Black keg	1	Maryland Office Side		
Green gazebo cover	1	Maryland Office Side		
Louvres glass	3	Maryland Office Side		
Small motar and pestle	1	Maryland Office Side		
Tomato jos board	1	Maryland Office Side		
Black collapsable table sets	3	Maryland Office Side		
Golden roll rafflle draw cage	1	Maryland Office Side		
Blue rug	1	Maryland Office Side		
Long cable extension roll	1	Maryland Office Side		
Stacked bundle sets of premier cool sign boards		Maryland Office Side		
Yellow & Red colored boards	10	Maryland Office Side		
Cobweb dusters	2	Maryland Office Side		
Straight pole small	16	Maryland Chidinma Office		
Meduim pole	15	Maryland Chidinma Office		
Canopy stand	4	Maryland Chidinma Office		
Net bundle	1	Maryland Chidinma Office		
Stage stand	4	Maryland Chidinma Office		
Net barrier	11	Maryland Chidinma Office		
Canopy top stand	8	Maryland Chidinma Office		
Stage base	2	Maryland Chidinma Office		
Tall stage set up stand at the back	3	Maryland Chidinma Office		
Black stage base setup at the back	6	Maryland Chidinma Office		
Silver steel rods	6	Maryland Chidinma Office		
Rolled net	1	Maryland Chidinma Office		
Water tanks	2	Maryland Chidinma Office		
Metal white tripod	1	Maryland Chidinma Office		
Curved black metal steel	3	Maryland Chidinma Office		
Car tire	1	Maryland Chidinma Office		
Pipes at the back	8	Maryland Chidinma Office		
Green metal fence	8	Maryland Chidinma Office		
Carex dart board	1	Maryland Chidinma Office		
Green gas cylinder	1	Maryland Beside Kitchen		
Valqunised iron	2	Maryland Beside Kitchen		
Blue drum	2	Maryland Beside Kitchen		
Wheel barrow	1	Maryland Beside Kitchen		
Devon kings keg small & big	1	Maryland Beside Kitchen		
Tyre	1	Maryland Beside Kitchen		
Yellow gen	1	Maryland Beside Kitchen		
Blue basket	1	Maryland Beside Kitchen		
Marry Me letter Boards	6	Ogba Upstairs		
Rolled silver net	1	Ogba Upstairs		
White Metal tripod rod	1	Ogba Upstairs		
Premier cube box	7	Ogba Upstairs		
Premier shower stand	8	Ogba Upstairs		
Gift box	4	Ogba Upstairs		
White Triangle wood & board	10	Ogba Upstairs		
Cussons baby flat board	5	Ogba Upstairs		
Robb flat board	2	Ogba Upstairs		
Ox fan head	1	Ogba Upstairs		
Floodlight cage	2	Ogba Upstairs		
Teddy bear	1	Ogba Upstairs		
Red&Black flowery sqaure pillow	3	Ogba Upstairs		
Sac filled with tapes on shower stand	1	Ogba Upstairs		
Sac filled with clothing props	3	Ogba Upstairs		
empty tv box	1	Ogba Upstairs		
empty brown box	1	Ogba Upstairs		
vechile windows	2	Ogba Upstairs		
Weight measurement scale	1	Ogba Upstairs		
Blue polythene bag with devon cloth	1	Ogba Upstairs		
Blue polythene bag with robb cloth	1	Ogba Upstairs		
Black polythene filled with yellow cloth	1	Ogba Upstairs		
Sac filled with small robb display boards	1	Ogba Upstairs		
Brown flat boards	3	Ogba Upstairs		
White nylon filled with traditional beads	1	Ogba Upstairs		
White paper box filled with quaker	1	Ogba Upstairs		
White paper box filled with good mama pamplets	1	Ogba Upstairs		
Mirror with light	1	Ogba Upstairs		
wine bottle	3	Ogba Upstairs		
carex stand	1	Ogba Upstairs		
bokku nylon with traditional clothes	1	Ogba Upstairs		
Frost machine	1	Ogba Upstairs		
givana cosmetics mini signs		Ogba Upstairs		
joy shower foot mat	1	Ogba Upstairs		
Old banner	2	Ogba Upstairs		
Preiemer cool mat	6	Ogba Upstairs		
Robb tray display board	1	Ogba Upstairs		
Writing board	1	Ogba Upstairs		
black bag of pull up banner base	2	Ogba Upstairs		
Colagte plastic strips		Ogba Upstairs		
Cussons baby flat board mini	6	Ogba Upstairs		
Brown box with tomato jos id & gele	1	Ogba Upstairs		
White box with spar book	1	Ogba Upstairs		
Kitchen sink	3	Ogba Upstairs		
Black setup stand bags	6	Ogba Upstairs		
Baby cussons cut out boards	16	Ogba Upstairs		
Plastic table leg	6	Ogba Upstairs		
1 haier thermocool choice board	1	Ogba Upstairs		
white boards beside carex stand	12	Ogba Upstairs		
Pink straight board	1	Ogba Upstairs		
Pink cupboard	1	Ogba Upstairs		
Ox fan head base	1	Ogba Upstairs		
Giavanis black shirt	1	Ogba Upstairs		
red big umbrella and rod	2	Ogba Upstairs		
Carex glow box	20	Downstairs Middle Floor		
Golden flag pole	8	Downstairs Middle Floor		
Nylon filled with 2 sure nose mask	1	Downstairs Middle Floor		
Mini Sac filled with thermocool shirt	1	Downstairs Middle Floor		
Surgical faace mask	1	Downstairs Middle Floor		
Sac containing traditional bead and adire	1	Downstairs Middle Floor		
Morning fresh square throw pillow	19	Downstairs Middle Floor		
Morning fresh round pillow	9	Downstairs Middle Floor		
Green polythene bad filled with carex uniform	1	Downstairs Middle Floor		
Black nylon bag filled with red petals and flowers	1	Downstairs Middle Floor		
feather banner	3	Downstairs Middle Floor		
Gas cooker	2	Downstairs Middle Floor		
Roll on banner	3	Downstairs Middle Floor		
Carex uniform sac	1	Downstairs Middle Floor		
Ariston boardpack	1	Downstairs Middle Floor		
Christmas tree rod		Downstairs Middle Floor		
Christmas tree & decoration		Downstairs Middle Floor		
plastic seat	2	Downstairs Middle Floor		
cussons baby registartion books	6	Downstairs Middle Floor		
tomato jos carton filled with registration books	1	Downstairs Middle Floor		
Edged2u Reg books	7	Downstairs Middle Floor		
robb tray boards	2	Downstairs Middle Floor		
nylon filled with rubber lighter	1	Downstairs Middle Floor		
Display promo handouts		Downstairs Middle Floor		
farm table	1	Ogba Side Store		
Farm chairs	2	Ogba Side Store		
Aircondition not working	1	Ogba Side Store		
Car tire not good	1	Ogba Side Store		
Jameson wooden table	2	Ogba Side Store		
wooden table with iron legs	2	Ogba Side Store		
haise chair	3	Ogba Side Store		
Generator	1	Ogba Side Store		
Jameson farm bench	7	Ogba Side Store		
Jameson farm table	1	Ogba Side Store		
2 by 2 wood	5	Ogba Side Store		
pepedem wash/cooking stand	2	Ogba Side Store		
inside cooking stand 3 water pipe	3	Ogba Side Store		
inside cooking stand	1	Ogba Side Store		
uncomplete cooking gas top	1	Ogba Side Store		
Jameson farm bench	4	Ogba Side Store		
Jameson green cupboard	8	Ogba Side Store		
White base complete	1	Ogba Side Store		
Display table	1	Ogba Side Store		
lather	1	Ogba Side Store		
carex army logo inside jameson green cupboard	9	Ogba Side Store		
cusson carex inside jameson green cupboard	11	Ogba Side Store		
white plywood	4	Ogba Side Store		
2 by 2 plywood	50	Ogba Side Store		
spinwheel at the back of plywood	2	Ogba Side Store		
plywood sheet	6	Ogba Side Store		
Jameson table	4	Ogba Side Store		
mamador cooking cupboard	2	Ogba Side Store		
Kings cooking cupboard	1	Ogba Side Store		
premiere cool wooden bar soap	2	Ogba Side Store		
mamador metal cupboard	1	Ogba Side Store		
plastic rubber stand	6	Ogba Side Store		
mockup display stand	4	Ogba Side Store		
Wooden riser tall	1	Ogba Side Store		
morning fresh 10x cupboard	1	Ogba Side Store		
table with iron legs	1	Ogba Side Store		
wooden table with foldable legs not in good condition	1	Ogba Side Store		
mamador metal cooking station	1	Ogba Side Store		
mamador wooden wash stand	1	Ogba Side Store		
Jamesoon bamboo false wall	1	Ogba Side Store		
display table	3	Ogba Side Store		
white base complete	1	Ogba Side Store		
black base	15	Ogba Side Store		
jameson basket false wall	1	Ogba Side Store		
waterpipe	1	Ogba Side Store		
plywood board thin	6	Ogba Side Store		
plywood board thick	1	Ogba Side Store		
morning fresh bottle mockup live size	2	Ogba Side Store		
Devon kings crate	1	Ogba Side Store		
pepedem cooking stand	1	Ogba Side Store		
Jameson wash stand	2	Ogba Side Store		
premiere cool display stand	1	Ogba Side Store		
yumyum unveil board	1	Ogba Side Store		
yellow branded plywood	5	Ogba Side Store		
Jameson farm table	1	Ogba Side Store		
Jameson farm bench	1	Ogba Side Store		
GREEN ASTROTAUF ROUGH	8	Ogba Office - Before Stairs		
GREEN ASTROTAUF SMOOTH	5	Ogba Office - Before Stairs		
GREEN ASTROTAUF SMOOTH NOT BIG	8	Ogba Office - Before Stairs		
BLUE ASTROTAUF ROUGH	2	Ogba Office - Before Stairs		
BLUE ASTROTAUF SMOOTH	1	Ogba Office - Before Stairs		
RED ASTROTAUF ROUGH	2	Ogba Office - Before Stairs		
RED ASTROTAUF SMOOTH	2	Ogba Office - Before Stairs		
RED ASTROTAUF SMALL ROUGH	1	Ogba Office - Before Stairs		
RED RUG	4	Ogba Office - Before Stairs		
GREEN RUG	1	Ogba Office - Before Stairs		
NAVY BLUE RUG	5	Ogba Office - Before Stairs		
BLUE RUG	8	Ogba Office - Before Stairs		
BLUE RUG small	5	Ogba Office - Before Stairs		
BROWN RUG small	1	Ogba Office - Before Stairs		
BLUE RUG small PIECES	1	Ogba Office - Before Stairs		
NAVY BLUE RUG VERY BIG+	1	Ogba Office - Before Stairs		
JAMESON GREEN TAMPOLINE	4	Ogba Office - Before Stairs		
FEATHER BANNER	1	Ogba Office - Before Stairs		
ROLL UP BANNER	8	Ogba Office - Before Stairs		
BOUNCING CASTLE PLUS 2 BLOWER INSIDE A BLACK SACK	1	Ogba Office - Before Stairs		
MANIQUE	2	Ogba Office - Before Stairs		
CHILDREN GOAL POST	1	Ogba Office - Before Stairs		
HAMPER NYLON	8	Ogba Office - Before Stairs		
SOCKAWAY VENT PIPE	1	Back of Ogba Office		
STAGE IRON	10	Back of Ogba Office		
BASE IRON FOR TAMPOLINE	30	Back of Ogba Office		
IRON FOR CONNECTING TAMPLINE	20	Back of Ogba Office		
STRAIGHT IRON	8	Back of Ogba Office		
Carex big x	1	Diamond Estate		
Iron Gate	1 PAIR	Diamond Estate		
Iron Gate standing by the wall	1	Diamond Estate		
Bamboo short	30	Diamond Estate		
2by2	19	Diamond Estate		
Plant with real on it	9	Diamond Estate		
Big thick short plank	8	Diamond Estate		
Small short plank	4	Diamond Estate		
Short 2by2	23	Diamond Estate		
Condemned wooden door	23	Diamond Estate		
Condemned wooden window	1	Diamond Estate		
Hdf board (Inside MD Compound)	5	Diamond Estate		
Plank (Inside MD Compound)	5	Diamond Estate		`;

function categorize(name) {
  const n = (name || '').toLowerCase();
  if (n.includes('chair') || n.includes('table') || n.includes('bench') || n.includes('stool') || n.includes('stand') || n.includes('base') || n.includes('pillow') || n.includes('wall') || n.includes('prop') || n.includes('riser')) {
    return 'Activation Props & Furniture';
  }
  if (n.includes('banner') || n.includes('board') || n.includes('mockup') || n.includes('sign') || n.includes('trade convention') || n.includes('prize') || n.includes('spinwheel')) {
    return 'Marketing & Branding Props';
  }
  if (n.includes('gazebo') || n.includes('canopy') || n.includes('tampoline') || n.includes('roof') || n.includes('umbrella')) {
    return 'Event Gazebos & Canopies';
  }
  if (n.includes('pot') || n.includes('spoon') || n.includes('sieve') || n.includes('cook') || n.includes('cup') || n.includes('plate') || n.includes('cutlery') || n.includes('gas') || n.includes('bread') || n.includes('motar')) {
    return 'Catering & Kitchen';
  }
  if (n.includes('light') || n.includes('stage') || n.includes('mirror') || n.includes('meter') || n.includes('cable') || n.includes('wire') || n.includes('extension') || n.includes('gen') || n.includes('elepaq')) {
    return 'Electrical & Lighting';
  }
  if (n.includes('wood') || n.includes('plank') || n.includes('plywood') || n.includes('2by2') || n.includes('2 by 2') || n.includes('door') || n.includes('window') || n.includes('bamboo')) {
    return 'Carpentry & Props';
  }
  if (n.includes('rug') || n.includes('astroturf') || n.includes('astrotauf') || n.includes('mat') || n.includes('floor')) {
    return 'Flooring & Carpets';
  }
  if (n.includes('christmas') || n.includes('santa') || n.includes('snow') || n.includes('rendiel') || n.includes('flower')) {
    return 'Seasonal & Holiday Decor';
  }
  if (n.includes('carex') || n.includes('shirt') || n.includes('jacket') || n.includes('vest') || n.includes('uniform') || n.includes('glove') || n.includes('mask') || n.includes('gele') || n.includes('adire')) {
    return 'Apparel & Merchandise';
  }
  if (n.includes('paint') || n.includes('cement') || n.includes('screed') || n.includes('seal') || n.includes('adhesive')) {
    return 'Paints & Construction';
  }
  if (n.includes('pipe') || n.includes('basin') || n.includes('sink') || n.includes('shower') || n.includes('water tank') || n.includes('vent') || n.includes('drum')) {
    return 'Plumbing & Sanitary';
  }
  if (n.includes('tyre') || n.includes('tire') || n.includes('headlight') || n.includes('engine') || n.includes('wheel barrow')) {
    return 'Automotive & Logistics';
  }
  if (n.includes('box') || n.includes('carton') || n.includes('sac') || n.includes('bag') || n.includes('bucket') || n.includes('keg') || n.includes('cooler') || n.includes('nylon') || n.includes('crate')) {
    return 'Storage & Packaging';
  }
  if (n.includes('book') || n.includes('reg') || n.includes('cardboard') || n.includes('handout') || n.includes('quaker')) {
    return 'Stationery & Print Materials';
  }
  return 'Hardware & Equipment';
}

const lines = rawTSV.trim().split('\n').slice(1);
const records = [];
let itemCounter = 1;

for (const line of lines) {
  const parts = line.split('\t');
  const name = (parts[0] || '').trim();
  const quantity_display = (parts[1] || '').trim();
  const location_of_item = (parts[2] || '').trim();
  const condition = (parts[3] || '').trim() || '—';
  const shelf_number = (parts[4] || '').trim() || '—';

  if (!name && !location_of_item) continue;
  if (!name) continue; // skip blank line entries

  let parsedQty = parseInt(quantity_display) || 1;
  if (quantity_display.includes('PAIR')) parsedQty = 2;

  const locCode = location_of_item.replace(/[^A-Za-z]/g, '').slice(0, 3).toUpperCase() || 'LOC';
  const sku = `INV-${locCode}-${String(itemCounter).padStart(3, '0')}`;

  records.push({
    sku,
    name,
    quantity_display: quantity_display || '1',
    stock_quantity: parsedQty,
    location_of_item: location_of_item || 'Warehouse Shelves',
    warehouse_name: location_of_item || 'Warehouse Shelves',
    condition: condition || '—',
    shelf_number: shelf_number || '—',
    category: categorize(name)
  });
  itemCounter++;
}

console.log(`Parsed ${records.length} valid physical inventory records.`);

// 1. Generate inventoryData.js
const inventoryDataContent = `// ==============================================================================
// EDGEWFORCE - CONSOLIDATED PHYSICAL INVENTORY DATASET
// Consolidated from 10 Location Sheets (Exact Source of Truth)
// ==============================================================================

export const CONSOLIDATED_INVENTORY = ${JSON.stringify(records, null, 2)};

export const PHYSICAL_INVENTORY_LOCATIONS = [
  'Warehouse Shelves',
  'Maryland Office Side',
  'Maryland Chidinma Office',
  'Maryland Beside Kitchen',
  'Ogba Upstairs',
  'Downstairs Middle Floor',
  'Ogba Side Store',
  'Ogba Office - Before Stairs',
  'Back of Ogba Office',
  'Diamond Estate'
];
`;

const inventoryDataPath = path.join(__dirname, '../data/inventoryData.js');
fs.writeFileSync(inventoryDataPath, inventoryDataContent, 'utf8');
console.log(`Written to ${inventoryDataPath}`);

// 2. Generate Supabase SQL schema update & data migration script
let sqlContent = `-- ==============================================================================
-- EDGEWFORCE - PHYSICAL INVENTORY DATABASE SCHEMA & DATA MIGRATION
-- Run this SQL in your Supabase SQL Editor to update the database schema and insert all 10 location items
-- ==============================================================================

-- 1. Ensure columns exist on products table
ALTER TABLE IF EXISTS products 
  ADD COLUMN IF NOT EXISTS location_of_item VARCHAR(255) DEFAULT 'Warehouse Shelves',
  ADD COLUMN IF NOT EXISTS shelf_number VARCHAR(100) DEFAULT '—',
  ADD COLUMN IF NOT EXISTS condition VARCHAR(100) DEFAULT '—',
  ADD COLUMN IF NOT EXISTS quantity_display VARCHAR(100) DEFAULT '1';

-- 2. Create index on location_of_item, shelf_number, and category for blazing-fast search
CREATE INDEX IF NOT EXISTS idx_products_location ON products(company_id, location_of_item);
CREATE INDEX IF NOT EXISTS idx_products_shelf ON products(company_id, shelf_number);
CREATE INDEX IF NOT EXISTS idx_products_condition ON products(company_id, condition);

-- 3. Upsert / Insert Consolidated Physical Inventory Records
`;

for (const rec of records) {
  const escName = rec.name.replace(/'/g, "''");
  const escLoc = rec.location_of_item.replace(/'/g, "''");
  const escCond = rec.condition.replace(/'/g, "''");
  const escShelf = rec.shelf_number.replace(/'/g, "''");
  const escCat = rec.category.replace(/'/g, "''");
  const escQtyDisp = rec.quantity_display.replace(/'/g, "''");

  sqlContent += `INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, '${rec.sku}', '${escName}', '${escCat}', 'pcs', 0, 0, 
  ${rec.stock_quantity}, '${escQtyDisp}', '${escLoc}', '${escLoc}', 
  '${escCond}', '${escShelf}', '${escShelf}', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

`;
}

const sqlPath = path.join(__dirname, '../data/schema_inventory_update.sql');
fs.writeFileSync(sqlPath, sqlContent, 'utf8');
console.log(`Generated SQL schema migration script at ${sqlPath}`);
