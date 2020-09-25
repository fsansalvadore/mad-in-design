class HomePage < ApplicationRecord
    validates :banner_image, size: {
                                less_than: 1000.kilobytes,
                                message: "deve pesare meno di 1MB" },
                                dimension: {
                                width: { max: 4000 },
                                height: { max: 3000 },
                                message: "deve essere alta meno di 4000px e larga meno di 3000px" }

    validates :box_1_image, size: {
                                less_than: 1000.kilobytes,
                                message: "deve pesare meno di 1MB" },
                                dimension: {
                                width: { max: 4000 },
                                height: { max: 3000 },
                                message: "deve essere alta meno di 4000px e larga meno di 3000px" }

    has_one_attached :banner_image
    has_one_attached :box_1_image
end
