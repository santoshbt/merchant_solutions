module ApplicationHelper
    def active(controller, action)
        return "active" if current_controller == controller && current_action == action 
        return nil
    end
end
