require "rails_helper"

describe 'wikis/show', :type => :view do

  context 'user sees a public wiki' do
    before do
      @wiki = assign(:wiki, build_stubbed(:wiki))
      assign(:pages, {})
      user = assign(:user, build_stubbed(:user))
      allow(view).to receive_messages(current_user: user)
    end

    it 'with update? false and show? false' do
      allow(view).to receive(:policy).and_return(double(update?: false, show?: false))
      render

      expect(rendered).to have_content @wiki.title
      expect(rendered).to have_content @wiki.description
      expect(rendered).to have_content 'Pages'
      expect(rendered).not_to have_content 'Edit Wiki'
      expect(rendered).not_to have_content 'Add Page'
      expect(rendered).not_to have_content 'Collaborators'
    end

    it 'with update? false and show? true' do
      allow(view).to receive(:policy).and_return(double(update?: false, show?: true))
      render

      expect(rendered).to have_content @wiki.title
      expect(rendered).to have_content @wiki.description
      expect(rendered).to have_content 'Pages'
      expect(rendered).not_to have_content 'Edit Wiki'
      expect(rendered).to have_content 'Add Page'
      expect(rendered).not_to have_content 'Collaborators'
    end

    it 'with update? true and show? false' do
      allow(view).to receive(:policy).and_return(double(update?: true, show?: false))
      render

      expect(rendered).to have_content @wiki.title
      expect(rendered).to have_content @wiki.description
      expect(rendered).to have_content 'Pages'
      expect(rendered).to have_content 'Edit Wiki'
      expect(rendered).not_to have_content 'Add Page'
      expect(rendered).not_to have_content 'Collaborators'
    end

    it 'with update? true and show? true' do
      allow(view).to receive(:policy).with(@wiki).and_return(double(update?: true, show?: true))
      render

      expect(rendered).to have_content @wiki.title
      expect(rendered).to have_content @wiki.description
      expect(rendered).to have_content 'Pages'
      expect(rendered).to have_content 'Edit Wiki'
      expect(rendered).to have_content 'Add Page'
      expect(rendered).not_to have_content 'Collaborators'
    end
  end

  context 'user sees a private wiki' do
    before do
      @wiki = assign(:wiki, build_stubbed(:wiki, private: true))
      assign(:pages, {})
      assign(:collaboration, build_stubbed(:collaboration))
      assign(:collaborations, {})
      user = assign(:user, build_stubbed(:user))
      allow(view).to receive_messages(current_user: user)
    end

    it 'with update? false and show? false' do
      allow(view).to receive(:policy).and_return(double(update?: false, show?: false))
      render

      expect(rendered).to have_content @wiki.title
      expect(rendered).to have_content @wiki.description
      expect(rendered).to have_content 'Pages'
      expect(rendered).not_to have_content 'Edit Wiki'
      expect(rendered).not_to have_content 'Add Page'
      expect(rendered).to have_content 'Collaborators'
      expect(rendered).not_to have_button 'Add User'
    end

    it 'with update? false and show? true' do
      allow(view).to receive(:policy).and_return(double(update?: false, show?: true))
      render

      expect(rendered).to have_content @wiki.title
      expect(rendered).to have_content @wiki.description
      expect(rendered).to have_content 'Pages'
      expect(rendered).not_to have_content 'Edit Wiki'
      expect(rendered).to have_content 'Add Page'
      expect(rendered).to have_content 'Collaborators'
      expect(rendered).not_to have_button 'Add User'
    end

    it 'with update? true and show? false' do
      allow(view).to receive(:policy).and_return(double(update?: true, show?: false))
      render

      expect(rendered).to have_content @wiki.title
      expect(rendered).to have_content @wiki.description
      expect(rendered).to have_content 'Pages'
      expect(rendered).to have_content 'Edit Wiki'
      expect(rendered).not_to have_content 'Add Page'
      expect(rendered).to have_content 'Collaborators'
      expect(rendered).to have_button 'Add User'
    end

    it 'with update? true and show? true' do
      allow(view).to receive(:policy).with(@wiki).and_return(double(update?: true, show?: true))
      render

      expect(rendered).to have_content @wiki.title
      expect(rendered).to have_content @wiki.description
      expect(rendered).to have_content 'Pages'
      expect(rendered).to have_content 'Edit Wiki'
      expect(rendered).to have_content 'Add Page'
      expect(rendered).to have_content 'Collaborators'
      expect(rendered).to have_button 'Add User'
    end
  end

  context 'visitor' do
    it "can see wiki and pages, but cannot manage wiki or pages" do
      @wiki = assign(:wiki, build_stubbed(:wiki))
      assign(:pages, {})
      allow(view).to receive_messages(current_user: nil)
      allow(view).to receive(:policy).and_return(double(update?: false, show?: false))
      render

      expect(rendered).to have_content @wiki.title
      expect(rendered).to have_content @wiki.description
      expect(rendered).to have_content 'Pages'
      expect(rendered).not_to have_content 'Edit Wiki'
      expect(rendered).not_to have_content 'Add Page'
      expect(rendered).not_to have_content 'Collaborators'
    end
  end
end