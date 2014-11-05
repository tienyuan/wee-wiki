require "rails_helper"

describe 'wikis/pages/show', :type => :view do

  context 'user sees a page from a public wiki' do
    before do
      @wiki = assign(:wiki, build_stubbed(:wiki))
      @page = assign(:page, build_stubbed(:page))
      user = assign(:user, build_stubbed(:user))
      allow(view).to receive_messages(current_user: user)
    end

    it 'with show? false' do
      allow(view).to receive(:policy).and_return(double(show?: false))
      render

      expect(rendered).to have_content @wiki.title
      expect(rendered).to have_content @wiki.description
      expect(rendered).not_to include 'glyphicon-lock'
      expect(rendered).to have_content @page.title
      expect(rendered).to have_content @page.body
      expect(rendered).not_to have_content 'Edit Page'
      expect(rendered).not_to have_content 'Delete Page'
    end

    it 'with show? true' do
      allow(view).to receive(:policy).and_return(double(show?: true))
      render

      expect(rendered).to have_content @wiki.title
      expect(rendered).to have_content @wiki.description
      expect(rendered).not_to include 'glyphicon-lock'
      expect(rendered).to have_content @page.title
      expect(rendered).to have_content @page.body
      expect(rendered).to have_content 'Edit Page'
      expect(rendered).to have_content 'Delete Page'
    end
  end

  context 'user sees a page from a private wiki' do
    before do
      @wiki = assign(:wiki, build_stubbed(:wiki, private: true))
      @page = assign(:page, build_stubbed(:page))
      user = assign(:user, build_stubbed(:user))
      allow(view).to receive_messages(current_user: user)
    end

    it 'with show? false' do
      allow(view).to receive(:policy).and_return(double(show?: false))
      render

      expect(rendered).to have_content @wiki.title
      expect(rendered).to have_content @wiki.description
      expect(rendered).to include 'glyphicon-lock'
      expect(rendered).to have_content @page.title
      expect(rendered).to have_content @page.body
      expect(rendered).not_to have_content 'Edit Page'
      expect(rendered).not_to have_content 'Delete Page'
    end

    it 'with show? true' do
      allow(view).to receive(:policy).and_return(double(show?: true))
      render

      expect(rendered).to have_content @wiki.title
      expect(rendered).to have_content @wiki.description
      expect(rendered).to include 'glyphicon-lock'
      expect(rendered).to have_content @page.title
      expect(rendered).to have_content @page.body
      expect(rendered).to have_content 'Edit Page'
      expect(rendered).to have_content 'Delete Page'
    end
  end

  context 'visitor' do
    it "can see wiki and pages, but cannot manage wiki or pages", focus: true do
      wiki = assign(:wiki, build_stubbed(:wiki))
      page = assign(:page, build_stubbed(:page))
      allow(view).to receive_messages(current_user: nil)
      allow(view).to receive(:policy).and_return(double(show?: false))
      render

      expect(rendered).to have_content wiki.title
      expect(rendered).to have_content wiki.description
      expect(rendered).to have_content page.title
      expect(rendered).to have_content page.body
      expect(rendered).not_to have_content 'Edit Page'
      expect(rendered).not_to have_content 'Delete Page'
    end
  end
end