require "TimedActions/ISBaseTimedAction"

MyTimedAction = ISBaseTimedAction:derive("MyTimedAction");

function MyTimedAction:isValid() -- Check if the action can be done
    return true;
end

function MyTimedAction:update() -- Trigger every game update when the action is perform
    print("Action is update");
end

function MyTimedAction:waitToStart() -- Wait until return false
    return false;
end

function MyTimedAction:start() -- Trigger when the action start
    print("Action start");
    self:setActionAnim("TakePills")

end

function MyTimedAction:stop() -- Trigger if the action is cancel
    print("Action stop");
    ISBaseTimedAction.stop(self);
end

function MyTimedAction:perform() -- Trigger when the action is complete
    print("Action perform");
    ISBaseTimedAction.perform(self);
end

function MyTimedAction:new(character) -- What to call in you code
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    o.character = character;
    o.maxTime = 30; -- Time take by the action
    if o.character:isTimedActionInstant() then o.maxTime = 1; end
    return o;
end