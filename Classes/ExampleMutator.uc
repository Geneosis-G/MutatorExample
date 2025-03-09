//The class name "ExampleMutator" must be changed to be iddentical to the name of this file when you rename it
class ExampleMutator extends GGMutator;

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//This file can be used to code global behaviour for your mutator										//
//Global behaviour do not apply to one player goat in particular, they just affect the world in general //
//////////////////////////////////////////////////////////////////////////////////////////////////////////

//These are integer variables of the ExampleMutator class
//class variables can only be defined between the first code line and the first function line (or before DefaultProperties if there is no function)
//class variables can be used in any function of this class and accessed on any object of this class
//Note the "m" as first letter, this is not mandatory, but it's a coding rule to easily make the difference between class variables and local variables
var int mTotalPoints;
var int mMaxPoints;

//This special section contains the default values of all class variables
//Any variable that do NOT appear here will be initialized to zero if it's a number, none if it's an object, false if it's a boolean and empty string if it's a string
DefaultProperties
{
	//mTotalPoints not defined, so it will be 0
	//mMaxPoints will start with the value 42
	mMaxPoints=42

	//This define the mutator component used with this mutator
	//It must be changed when you rename the "ExampleMutatorComponent" class
	mMutatorComponentClass=class'ExampleMutatorComponent'
}