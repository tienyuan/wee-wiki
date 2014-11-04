require "rails_helper"

describe 'wikis/show.html.haml', :type => :view do

  context 'current_user for a public wiki' do
    it 'can see wiki link' do
      wiki = assign(:wiki, build_stubbed(:wiki))
      user = assign(:user, build_stubbed(:user))
      allow(view).to receive_messages(current_user: user)
      allow(view).to receive(:policy).and_return double(edit?: false, destroy?: true)

      render

      expect(rendered).to have_content 'Pages'
      expect(rendered).not_to have_content 'Collaborators'
    end
  end

  context 'current_user for a private wiki' do
    it 'can see wiki link' do
      wiki = assign(:wiki, build_stubbed(:wiki, private: true))
      user = assign(:user, build_stubbed(:user))
      allow(view).to receive_messages(current_user: user)
      allow(view).to receive(:policy).and_return double(edit?: false, destroy?: true)
      
      render

      expect(rendered).to have_content 'Pages'
      expect(rendered).to have_content 'Collaborators'
    end
  end

  context 'visitor' do
    it "can see sign up link" do
      wiki = assign(:wiki, build_stubbed(:wiki))
      allow(view).to receive_messages(current_user: nil)
      allow(view).to receive(:policy).and_return double(edit?: false, destroy?: true)
      
      render

      expect(rendered).to have_content 'Pages'
    end
  end
end