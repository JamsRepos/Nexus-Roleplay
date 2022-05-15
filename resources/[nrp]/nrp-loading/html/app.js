var count = 0;
var thisCount = 0;
var percentage = 0;

var stateCount = 4;
var states = {};
//Cache to keep track of all progress values.
//This is need for the Math.max functions (so no backwards progressbars).
var progressCache = [];

var types = [
    "INIT_CORE",
    "INIT_BEFORE_MAP_LOADED",
    "MAP",
    "INIT_AFTER_MAP_LOADED",
    "INIT_SESSION"
];

setInterval(UpdateTotalProgress, 1000);


const handlers = {
    startInitFunction(data)
    {
        //Create a entry for every type.
        if(states[data.type] == null)
        {
            states[data.type] = {};
            states[data.type].count = 0;
            states[data.type].done = 0;
        }
    },

    startInitFunctionOrder(data)
    {
        //Collect the total count for each type.
        if(states[data.type] != null)
        {
            states[data.type].count += data.count;
        }
    },

    initFunctionInvoked(data)
    {
        //Increment the done accumulator based on type.
        if(states[data.type] != null)
        {
            states[data.type].done++;
        }
    },

    startDataFileEntries(data)
    {
        //Manually add the MAP type.
        states["MAP"] = {};
        states["MAP"].count = data.count;
        states["MAP"].done = 0;
    },

    performMapLoadFunction(data)
    {
        //Increment the map done accumulator.
        states["MAP"].done++;
    },

    // initFunctionInvoking(data) {
    //     percentage = Math.round((100 - (data.idx / count) * 100));

    //     if (percentage == 0) {
    //         percentage = -10;
    //     }

    //     document.getElementById('water').style.transform = 'translateY(' + percentage + '%)';
    // },

    // startDataFileEntries(data) {
    //     count = data.count;
    // },

    // performMapLoadFunction(data) {
    //     ++thisCount;

    //     percentage = Math.round((100 - (thisCount / count) * 100));

    //     if (percentage == 0) {
    //         percentage = 105;
    //     }

    //     document.getElementById('water').style.transform = 'translateY(' + percentage + '%)';
    // },
};

window.addEventListener('message', function (e) {
    (handlers[e.data.eventName] || function () { })(e.data);
});

function UpdateTotalProgress()
{
        //Set the total progress counter:
        var total = GetTotalProgress();
        var totalProgress = document.getElementById('water');

        if(progressCache[10] != null)
        {
            total = Math.max(total, progressCache[10]);
        }

        var percentage = Math.round(100 - total)

        if(percentage == 40) {
            percentage = 0;
        }

        totalProgress.style.transform = 'translateY(' + percentage + '%)';
        progressCache[10] = total;
        console.log(percentage);
}


//Get the progress of a specific type. (See types array).
function GetTypeProgress(type)
{
    if(states[type] != null)
    {
        var progress = states[type].done / states[type].count;
        return Math.round(progress * 100);
    }

    return 0;
}

//Get the total progress for all the types.
function GetTotalProgress()
{
    var totalProgress = 0;
    var totalStates = 0;

    for(var i = 0; i < types.length; i++)
    {
        var key = types[i];
        totalProgress += GetTypeProgress(key);
        totalStates++;
    }

    //Dont want to divide by zero because it will return NaN.
    //Be nice and return a zero for us.
    if(totalProgress == 0) return 0;

    return totalProgress / totalStates;
}