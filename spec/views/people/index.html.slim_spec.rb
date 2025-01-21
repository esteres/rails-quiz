require "rails_helper"

describe "people/index.html.slim", type: :view do

  def generate_people(count)
    Kaminari.paginate_array(
      Array.new(count) do |i|
        Person.create(
          name: "Person #{i + 1}",
          phone_number: "1234567890",
          email: "person#{i + 1}@example.com",
          company: Company.create(name: "Test Company")
        )
      end
    )
  end

  shared_examples "renders people table" do |pagination_controls|
    it "displays the heading 'Viewing people'" do
      expect(rendered).to have_selector("h2", text: "Viewing people")
    end

    it "renders the table headers correctly" do
      expect(rendered).to have_selector("table.table thead tr") do
        expect(rendered).to have_selector("th", text: "ID")
        expect(rendered).to have_selector("th", text: "Name")
        expect(rendered).to have_selector("th", text: "Phone number")
        expect(rendered).to have_selector("th", text: "Email address")
        expect(rendered).to have_selector("th", text: "Company")
      end
    end

    it "renders pagination controls as expected" do
      if pagination_controls
        expect(rendered).to have_selector("nav>ul.pagination")
      else
        expect(rendered).not_to have_selector("nav>ul.pagination")
      end
    end
  end

  context "when there are more than 10 records" do
    let(:people) { generate_people(15) }
    before do
      assign(:people, people.page(1).per(10))
      render
    end

    include_examples "renders people table", true


    it "renders each person's details in the table" do
      people.each_with_index do |person, index|
        row_selector = "table.table tbody tr:nth-child(#{index + 1})"

        expect(rendered).to have_selector(row_selector) do |row|
          expect(row).to have_selector("th", text: person.id.to_s)
          expect(row).to have_selector("td", text: person.name)
          expect(row).to have_selector("td", text: person.phone_number)
          expect(row).to have_selector("td", text: person.email)
          expect(row).to have_selector("td", text: person.company.name)
        end
      end
    end
  end

  context "when there are less than 10 records" do
    let(:people) { generate_people(5) }
    before do
      assign(:people, people.page(1).per(10))
      render
    end

    include_examples "renders people table"

    it "renders each person's details in the table" do
      people.each_with_index do |person, index|
        row_selector = "table.table tbody tr:nth-child(#{index + 1})"

        expect(rendered).to have_selector(row_selector) do |row|
          expect(row).to have_selector("th", text: person.id.to_s)
          expect(row).to have_selector("td", text: person.name)
          expect(row).to have_selector("td", text: person.phone_number)
          expect(row).to have_selector("td", text: person.email)
          expect(row).to have_selector("td", text: person.company.name)
        end
      end
    end
  end
end
