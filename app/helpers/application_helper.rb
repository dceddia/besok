module ApplicationHelper
  def main_page?
    # TODO: might need to add another check in here like "and action == 'index'"
    controller.class == WelcomeController
  end
end
