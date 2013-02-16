# Synaptic Wall Project

## Instructions
* Press *1* to switch to _Creation_ mode. Click to create a soma. Click and drag existing somas to change their location. Click on the outer ring around a Soma to change it's threshold level.
* Press *2* to switch to _Deletion_ mode. Click to delete (*not implemented*)
* Press *3* to switch to _Interaction_ mode. Click and drag on the sliders to change properties. Click on empty areas to create selection boxes. When at least one object is selected, the control panel that can control all corresponding elements in the selection
* Press *4* to switch to _Handwriting_ mode. Click and drag to draw. Draw a rough circle to create a circle.
* Press *m* to show a zoom lense, move the mouse around to move the focus of the lense
* Press *p* to pause rendering
* Press *o* to resume rendering
* Press *c* to clear the screen

---

## Design

### Enviroment
#### [SynapticWallBase.pde][]
This file sets up the environment and delegates all the events to the global [Synaptic_Wall][] object and sets up the [Grid][] used to place objects and define paths

#### [SynapticWall.pde][]
The controller for all inputs such as mouse interactions and keypress events. It handles state transitions and keeps track of what current mode (creation, deletion, interaction) it's in and determines the result of each input depending on context. It's also responsible for sending interaction events down to the [ObjectCollection][], the [Grid][], the [ControlPanel][], as well as other temporary objects being created.

#### [Selector.pde][]
An utility object that keeps the state, renders, and provide information about the selection rectangle

#### [Grid.pde][]
Geometric Grid used for positioning objects in the world with constraints in order to have geometric appeareances and properties

#### [Constants.pde][]
All constants used for rendering or calculations are defined within this file. It's then made available to all objects through inheritance. Some constants can be recalculated based on a scale constant

---

### Objects

#### [Drawable.pde][]
*Abstract* class that extends [Constants][] that keeps track for basic information such as location, color, creation time, and flags such as Visible and Movable

#### [Interactive.pde][]
*Abstract* class that extends [Drawable][] that defines the methods used for handling events and interactions with default implementations

#### [Shape.pde][]
*Abstract* Class that extends [Interactive][] that provides methods for adjusting locations of objects

##### [ControllableShape.pde][]
*Abstract* Class that extends [Shape][] that contains default behavior for shapes that have controls

#### [Cell.pde][]
*Abstract* Class that extends [ControllableShape][] that outlines how Shapes interact with [Paths][Path] and fire signal

##### [Soma.pde][]
Class that extends [Cell][] that contains Soma specific behavior and rendering, such as the decay of the Soma's potential and how [Action Potentials][ActionPotential] are fired

##### [Initiator.pde][]
Class that extends [Cell][] that contains Initiator specific behavior and   rendering, such as how [Post Synaptic Potentials][PostsynapticPotential] are generated and the parameters that control the firing behavior of the cell

#### [Synapse.pde][]
Class that extends [ControllableShape][] that specifies how a Synapse updates its appearance and state based on its firing timer

#### [Path.pde][]
*Abstract* Class that extends [Interactive][] that details how Paths ([Axons][Axon] and [Dendrites][Dendrite]) process signals, junctions, and events

##### [Axon.pde][]
Class that extends [Path][] that contains Axon specific behavior logic and rendering code

##### [Dendrite.pde][]
Class that extends [Path][] that contains Dendrite specific behavior logic and rendering code

#### [Collection.pde][]
A class that contains methods for adding or removing items from the collection, event handling, selection, and rendering

##### [ObjectCollection.pde][]
The collection that keeps track of all the primary objects ([Soma][], [Initiator][], [Dendrite][], [Axon][], [Synapse][]) in Synaptic Wall

---

### Controls

#### [Control.pde][]
*Abstract* Class that extends [Interactive][] that contains fields required for Control objects

#### [Controllable.pde][]
Interface that defines how objects can interact with Controllable objects

#### [Slider.pde][]
Slider UI element that maps a value within a range

##### [LinearSlider.pde][]
A simple rectangular [Slider][] that maps values along the x axis

##### [CircularSlider.pde][]
A circular [Slider][] that maps values to radian angles

###### [DiscreteCircularSlider.pde][]
A [CircularSlider][] that allows only integer values

###### [DoubleEndedSlider.pde][]
A [CircularSlider][] that allows a range of values instead of a single particular value on the slider

###### [ThresholdSlider.pde][]
A [CircularSlider][] that's used to represent a Cell's firing potential

---

### Control Panel
#### [ControlPanel.pde][]
A object that encapsulates the objects in the Control Panel on the right side of the app and manages its behavior in response to control adjustments and interactions

#### [ControllerSoma.pde][]
A [Soma][] SubClass that's used to display special information in the [Control Panel][ControlPanel]

#### [ControllerSynapse.pde][]
A [Synapse][] SubClass that's used to display special information in the [Control Panel][ControlPanel]


---

### Utilities

#### [Timer.pde][]
A timer object that can fire an event at a particular point in the future

#### [Util.pde][]
A collection of utility functions that are used throughout the code base to do computation

#### [Plugins.pde][]
Processing plugin functions that provide functions to draw shapes such as arcs and rings

#### [Plot.pde][]

---

<!-- Nav Links -->

[ActionPotential]: #actionpotentialpde
[Axon]: #axonpde
[Cell]: #cellpde
[CircularSlider]: #circularsliderpde
[Collection]: #collectionpde
[Constants]: #constantspde
[Control]: #controlpde
[Controllable]: #controllablepde
[ControllableShape]: #controllableshapepde
[ControllerSoma]: #controllersomapde
[ControllerSynapse]: #controllersynapsepde
[ControlPanel]: #controlpanelpde
[Dendrite]: #dendritepde
[DiscreteCircularSlider]: #discretecircularsliderpde
[DoubleEndedSlider]: #doubleendedsliderpde
[Drawable]: #drawablepde
[Grid]: #gridpde
[Initiator]: #initiatorpde
[Interactive]: #interactivepde
[LinearSlider]: #linearsliderpde
[ObjectCollection]: #objectcollectionpde
[Path]: #pathpde
[Plot]: #plotpde
[Plugins]: #pluginspde
[PostsynapticPotential]: #postsynapticpotentialpde
[Selector]: #selectorpde
[Shape]: #shapepde
[Signal]: #signalpde
[Signalable]: #signalablepde
[SignalVisualizer]: #signalvisualizerpde
[Slider]: #sliderpde
[Soma]: #somapde
[Synapse]: #synapsepde
[Synaptic_Wall]: #synapticwallpde
[SynapticWall]: #synapticwallpde
[SynapticWallBase]: #synapticwallbasepde
[ThresholdSlider]: #thresholdsliderpde
[Timer]: #timerpde
[Util]: #utilpde

<!-- Files Links -->

[ActionPotential.pde]: /SynapticWall/SynapticWall/blob/master/ActionPotential.pde
[Axon.pde]: /SynapticWall/SynapticWall/blob/master/Axon.pde
[Cell.pde]: /SynapticWall/SynapticWall/blob/master/Cell.pde
[CircularSlider.pde]: /SynapticWall/SynapticWall/blob/master/CircularSlider.pde
[Collection.pde]: /SynapticWall/SynapticWall/blob/master/Collection.pde
[Constants.pde]: /SynapticWall/SynapticWall/blob/master/Constants.pde
[Control.pde]: /SynapticWall/SynapticWall/blob/master/Control.pde
[Controllable.pde]: /SynapticWall/SynapticWall/blob/master/Controllable.pde
[ControllableShape.pde]: /SynapticWall/SynapticWall/blob/master/ControllableShape.pde
[ControllerSoma.pde]: /SynapticWall/SynapticWall/blob/master/ControllerSoma.pde
[ControllerSynapse.pde]: /SynapticWall/SynapticWall/blob/master/ControllerSynapse.pde
[ControlPanel.pde]: /SynapticWall/SynapticWall/blob/master/ControlPanel.pde
[Dendrite.pde]: /SynapticWall/SynapticWall/blob/master/Dendrite.pde
[DiscreteCircularSlider.pde]: /SynapticWall/SynapticWall/blob/master/DiscreteCircularSlider.pde
[DoubleEndedSlider.pde]: /SynapticWall/SynapticWall/blob/master/DoubleEndedSlider.pde
[Drawable.pde]: /SynapticWall/SynapticWall/blob/master/Drawable.pde
[Grid.pde]: /SynapticWall/SynapticWall/blob/master/Grid.pde
[Initiator.pde]: /SynapticWall/SynapticWall/blob/master/Initiator.pde
[Interactive.pde]: /SynapticWall/SynapticWall/blob/master/Interactive.pde
[LinearSlider.pde]: /SynapticWall/SynapticWall/blob/master/LinearSlider.pde
[ObjectCollection.pde]: /SynapticWall/SynapticWall/blob/master/ObjectCollection.pde
[Path.pde]: /SynapticWall/SynapticWall/blob/master/Path.pde
[Plot.pde]: /SynapticWall/SynapticWall/blob/master/Plot.pde
[Plugins.pde]: /SynapticWall/SynapticWall/blob/master/Plugins.pde
[PostsynapticPotential.pde]: /SynapticWall/SynapticWall/blob/master/PostsynapticPotential.pde
[Selector.pde]: /SynapticWall/SynapticWall/blob/master/Selector.pde
[Shape.pde]: /SynapticWall/SynapticWall/blob/master/Shape.pde
[Signal.pde]: /SynapticWall/SynapticWall/blob/master/Signal.pde
[Signalable.pde]: /SynapticWall/SynapticWall/blob/master/Signalable.pde
[SignalVisualizer.pde]: /SynapticWall/SynapticWall/blob/master/SignalVisualizer.pde
[Slider.pde]: /SynapticWall/SynapticWall/blob/master/Slider.pde
[Soma.pde]: /SynapticWall/SynapticWall/blob/master/Soma.pde
[Synapse.pde]: /SynapticWall/SynapticWall/blob/master/Synapse.pde
[SynapticWall.pde]: /SynapticWall/SynapticWall/blob/master/SynapticWall.pde
[SynapticWallBase.pde]: /SynapticWall/SynapticWall/blob/master/SynapticWallBase.pde
[ThresholdSlider.pde]: /SynapticWall/SynapticWall/blob/master/ThresholdSlider.pde
[Timer.pde]: /SynapticWall/SynapticWall/blob/master/Timer.pde
[Util.pde]: /SynapticWall/SynapticWall/blob/master/Util.pde