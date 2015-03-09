module Adventure where

import Debug.Trace
import Data.Array (map)
import Data.List

--Currently trying to add in the characters for the game
--Will then try to create some of the objects


-- Game Types --


data Person = Person
   { name :: String
   , age :: Number 
   , relationship :: String
   }
   
newtype Thing = Thing
   { name :: String
   , edible :: Boolean
   }
   
newtype Room = Room
   { name :: String
   , people :: [Person] 
   , things :: [Thing] 
   , rooms :: [Room] 
   }


-- Type Accessors --

   
getPersonName :: Person -> String
getPersonName (Person p) = p.name

getRoomName :: Room -> String
getRoomName (Room r) = r.name

getThingName :: Thing -> String
getThingName (Thing o) = o.name
   

-- Type Data-Display Functions --

   
instance showRoom :: Show Room where
	show (Room o) = ":Room:\n " ++ show o.name ++
	"\n=ROOM DATA=" ++
	"\n:People:\n " ++ show (map (getPersonName) o.people)  ++
	"\n:Things:\n" ++ show (map (getThingName) o.things) ++
	"\n:Connected Rooms:" ++ show (map (getRoomName) o.rooms)

instance showPerson :: Show Person where
	show (Person o) = "Person: " ++ show o.name ++ " Age: " ++ show o.age ++ "\n"

instance showThing :: Show Thing where
	show (Thing o) = "Object: " ++ show o.name ++ "\nEdible: " ++ show o.edible ++ "\n"



-- Next Possible Steps:
-- Saving/Loading from JSON
-- Putting player into room
-- Allowing player basic interaction with room and its people/things
-- Structuring the program in a way that would allow the player to
--		use functions to edit people/rooms/things instead of
--		doing everything through let constructors


-- World code, doesn't work yet
--instance showWorld :: Show World where
--	show (World o) = "World: " ++ show o.name ++
--	"\n=WORLD DATA=" ++
--	"\n:Rooms:\n" ++ show (map (getRoomName) o.rooms)

--newtype World = World
--   { name :: String
--   , rooms :: [Room] 
--   }

--addRoomToWorld :: Room -> World -> World
--addRoomToWorld r w = Cons r w

-- ================Adding some Code to construct the world/players/items/displaying some instructions(you guys might want to modify this=======

-- Just some basic instructions
instructions = 
	"To move around you must specify your actions in a word or two\n" ++ 
	"The available commands are:\n" ++
	"Look Around:  Check out where you're at"  ++
	"Go to ___       Which room do you want to check out?\n" ++
	"Pick Up ___     Any cool gear you want to take with you?\n" ++
	"Talk to ____    If you want to talk to someone in the room\n" ++			   
	"Tell ____       If you find someone worthy of being saved >:]\n" 
	"Stand up        Time to get going!\n" ++
	"Get ___         Get something\n" ++
	"Feed Max        Feed the Pug :3\n" ++ 
	"Call Emily      Ring Ring Ring \n" 



	
-- Let's create some characters  the ages can be re-adjusted
--The 'personYou' this can be re-adjusted once I can figure I/O out :D

personYou :: Person
personYou = { name: "You", age: 23, relationship: "you"}

personCody :: Person
personCody = {name: "Cody", age: 23, relationship: "housemate"}

personEmily :: Person
personEmily = {name: "Emily", age: 22, relationship: "roommate"}

personEllen :: Person
personEllen = {name: "Ellen", age: 28, relationship: "boss"}

personMax :: Person --Not actually a person but will help us in writing game using them as such
personMax = {name: "Max", age: 5, relationship: "dog"}


--=========Let's create some objects, do we want any attributes to these? ============
oNote :: Thing
oNote = {name: "string", edible: false} 

oCoffe :: Thing
oCoffe = {name: "coffee", edible: true}
--add more as I make way through story

nothing :: Thing
nothing = {name: "nothing", edible: false}
--============Time to set up the rooms=============------------
livingRoom :: Room 
livingRoom = {name: "Living Room", people: [personMax], things: [nothing], rooms: [bedRoom, kitchen, bathroom]}

bedRoom :: Room
bedRoom = {name: "Bed Room", people: [personMax], things: [nothing], rooms: [livingRoom, kitchen, bathroom]}

